Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWFIUsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWFIUsI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWFIUsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:48:08 -0400
Received: from [80.71.248.82] ([80.71.248.82]:20143 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S965213AbWFIUsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:48:06 -0400
X-Comment-To: Joel Becker
To: Alex Tomas <alex@clusterfs.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Andreas Dilger <adilger@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
	<20060609181020.GB5964@schatzie.adilger.int>
	<Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
	<m31wty9o77.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse>
	<1149880865.22124.70.camel@localhost.localdomain>
	<m3irna6sja.fsf@bzzz.home.net> <4489CB42.6020709@garzik.org>
	<m3wtbq5dgw.fsf@bzzz.home.net>
	<20060609204418.GG3574@ca-server1.us.oracle.com>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Sat, 10 Jun 2006 00:49:54 +0400
In-Reply-To: <20060609204418.GG3574@ca-server1.us.oracle.com> (Joel Becker's message of "Fri, 9 Jun 2006 13:44:18 -0700")
Message-ID: <m3fyie5a19.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Joel Becker (JB) writes:

 JB> On Fri, Jun 09, 2006 at 11:35:43PM +0400, Alex Tomas wrote:
 >> that's your point of view. mine is that this option (and code)
 >> to be used only when needed. 

 JB> 	Which is irrelevant.  If you tell the world "extents are
 JB> better!", they're going to turn them on regardless of whether you
 JB> consider their situation a good candidate.  Many non-kernel-hackers
 JB> started using reiserfs before it was usably stable, just because
 JB> "journaling is better!"

I haven't said that so far. I feel absolutely comfortable to put
as many warnings as needed from your point of view.

thanks, Alex
