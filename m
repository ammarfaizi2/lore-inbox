Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264009AbTCXAJZ>; Sun, 23 Mar 2003 19:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264012AbTCXAJZ>; Sun, 23 Mar 2003 19:09:25 -0500
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:45986 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP
	id <S264009AbTCXAJX> convert rfc822-to-8bit; Sun, 23 Mar 2003 19:09:23 -0500
Date: Sun, 23 Mar 2003 17:20:21 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Sven Schuster <schuster.sven@gmx.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
In-Reply-To: <3E7E4C63.908@gmx.de>
Message-ID: <Pine.LNX.4.44.0303231717390.19670-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Mar 2003, Sven Schuster wrote:

> Jörn Engel wrote:
> 
> >On Sun, 23 March 2003 14:38:10 -0500, Alan Cox wrote:
> >  
> >
> >>-	Anyone can go and release their own 2.4.20.1 or 2.4.20-sec or
> >>	whatever if they feel strongly about it
> >>
> >>Just go do it. If someone wants to be a contact point for build existing
> >>base kernels + published security fix trees I'm pretty sure kernel.org
> >>would host them too.
> >>    
> >>
> >
> >Sounds like a good idea. Ideal would be a person with a lottle
> >knowledge about security or at least, about this particular patch.
> >
> >I would volunteer, if noone else does. But just about anyone would be
> >closer to that ideal person, so consider me to be the last resort.
> >
> >Jörn
> >  
> >
> 
> I think a solution like this would be best, having a "-fix" tree or 
> similar for
> the latest stable kernel maintained by a volunteer and hosted by kernel.org.
> 
> Optionally or alternatively there could/should be a mailinglist (yes, one
> more :-) where all critical fixes like sec + fs fixes, etc. are posted to,
> for people building their own kernels (and interested in staying
> up-to-date) but not willing/having the time/able to dig through the tons
> of emails brought by lkml. Cause I think if you're not an active kernel
> developer or having some issues with running a kernel, or like me, just
> interested and still learning to understand linux kernel programming in
> the far future ;-) you shouldn't have to read lkml just for building and
> maintaining your own, none-vendor kernel. Btw, if you had to, I think
> there might even be the danger of loosing some critical fixes in the loads
> of emails.

Hi,
In an earlier email I posted a URL to an updates directory containing
strictly updates for the current 2.4 kernel tree.  The URL is
http://www.hardrock.org/kernel/current-updates/

Currently there is the ext3 patch, tg3 patch and ptrace patch.  Also is one
single patch with all three patches include.

Regards
James Bourne 

> Sven

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

