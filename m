Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWBJX2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWBJX2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWBJX2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:28:13 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:18913 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932243AbWBJX2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:28:12 -0500
Date: Sat, 11 Feb 2006 00:28:08 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, tytso@mit.edu,
       peter.read@gmail.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jim@why.dont.jablowme.net,
       jengelh@linux01.gwdg.de
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060210232807.GB5713@stiffy.osknowledge.org>
References: <43EC887B.nailISDGC9CP5@burner> <mj+md-20060210.123726.23341.atrey@ucw.cz> <43EC8E18.nailISDJTQDBG@burner> <Pine.LNX.4.61.0602101409320.31246@yvahk01.tjqt.qr> <43EC93A2.nailJEB1AMIE6@burner> <20060210141651.GB18707@thunk.org> <43ECA3FC.nailJGC110XNX@burner> <20060210145238.GC18707@thunk.org> <43ECA934.nailJHD2NPUCH@burner> <20060210154256.GG28676@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210154256.GG28676@harddisk-recovery.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g418aade4-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Erik Mouw <erik@harddisk-recovery.com> [2006-02-10 16:42:56 +0100]:

> On Fri, Feb 10, 2006 at 03:54:44PM +0100, Joerg Schilling wrote:
> > "Theodore Ts'o" <tytso@mit.edu> wrote:
> > > On Fri, Feb 10, 2006 at 03:32:28PM +0100, Joerg Schilling wrote:
> > > > A particular file on the system must not change st_dev while the system
> > > > is running.
> > > > 
> > > > http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
> > >
> > > 1)  File != device.
> > 
> > I am sorry, but it turns out that you did not understand the problem.
> 
> Why do you start an ad hominem attack every time somebody shows you're
> wrong for technical reasons?

Duuude ... could you all calm down and get the facts together? What if you'd all
be in the same room with a knife by the hand every one of you?!

I suggest Joerg summarizes the facts from his point of view _in detail_ and
people are going to respond to it. I think it pretty useless to get people
respond to you, Joerg, where you just drop a two-liner where one line is that
someone is stupid or not as good at something and the other line is a quick
statement that just always leaves place for people to ask more questions and
proceed arguing.

Please clarify. Summarize. This whole thing turns into some totally useles infitine
state machine...

Thanks anyone for your eyes. :)

Marc
