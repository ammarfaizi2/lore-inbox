Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTBUDEd>; Thu, 20 Feb 2003 22:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTBUDEd>; Thu, 20 Feb 2003 22:04:33 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:41859 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267079AbTBUDEc>; Thu, 20 Feb 2003 22:04:32 -0500
Date: Thu, 20 Feb 2003 15:14:48 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stacy Woods <spwoods@us.ibm.com>
Subject: Re: Bugs sitting in RESOLVED state
In-Reply-To: <276780000.1045791394@flay>
Message-ID: <Pine.LNX.4.44.0302201500260.2145-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2003, Martin J. Bligh wrote:

> > Also, several of my 'resolved' bugs have comments that clearly indicate
> > the fix has been merged.  So, now I must go in a clicking spree, taking
> > valuable time away from hacking :)  Don't we have kind and gracious
> > Bugzilla janitors for this sort of thing?
> 
> heh ;-) will try to sort something out for that ... we ought to go through
> each one and do a simple check like that, before we send out such lists.

I went back through and marked most of Jeff's "resolved" bugs as closed.  
The one I left as closed is number 85, concerning use of cli and friends 
in hamradio.  An inspection of the source in 2.5.62 shows they are still 
there.  If there was a patch to correct this, it apparently still hasn't 
been merged in latest bk.

