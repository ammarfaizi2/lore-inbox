Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUI2TqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUI2TqD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268896AbUI2TqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:46:02 -0400
Received: from mail.dif.dk ([193.138.115.101]:27595 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267703AbUI2TpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:45:00 -0400
Date: Wed, 29 Sep 2004 21:52:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: George Anzinger <george@mvista.com>
Cc: Christoph Lameter <clameter@sgi.com>, Ulrich Drepper <drepper@redhat.com>,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: Posix compliant CLOCK_PROCESS/THREAD_CPUTIME_ID V4
In-Reply-To: <415B0C9E.5060000@mvista.com>
Message-ID: <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
 <415B0C9E.5060000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unrelated to the CLOCK_PROCESS/THREAD_CPUTIME_ID discussion, just wanted 
to comment on the 'patches inline vs attached' bit.

On Wed, 29 Sep 2004, George Anzinger wrote:

> Christoph Lameter wrote:
> > On Wed, 29 Sep 2004, George Anzinger wrote:
> > 
> > > Christoph Lameter wrote:
> > > 
> > > Please, when sending patches, attach them.  This avoids problems with
> > > mailers,
> > > on both ends, messing with white space.  They still appear in line, at
> > > least in
> > > some mailers (mozilla in my case).
> > 
> > 
> > The custom on lkml, for Linus and Andrew is to send them inline. I also
> > prefer them inline. Will try to remember sending attachments when sending a
> > patch to you.
> 
> I think they WILL be inline as well as attached if you attach them.  The
> difference is that in both presentations neither mailer will mess with white
> space.  This means that long lines will not be wrapped and tabs vs space will
> not be changed.
> 
Not all mailers show attachments inline. Mailers that do usually depend on 
the mimetype of the attachment when choosing to show inline or not. pine 
(my personal favorite) show attachments with a text/plain and similar 
mime-type inline, but a not all mailers use that (I see a lot of attached 
patches on lkml that don't show inline, and that's somewhat annoying).

It's also harder to reply and comment on bits of a patch when your mailer 
does not include attachments inline in a reply (even if it did show them 
inline while reading the mail).
Having to save the patch, open it in a text editor and then cut'n'paste 
bits of it into the reply mail is a pain. Same goes for having to save & 
open it in order to read it in the first place.

--
Jesper Juhl

