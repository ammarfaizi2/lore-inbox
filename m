Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUG0Ss0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUG0Ss0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUG0SrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:47:17 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:48382 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S266560AbUG0Sme
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:42:34 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 14:42:33 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <200407271402.59846.gene.heskett@verizon.net> <20040727105039.052352d8.rddunlap@osdl.org>
In-Reply-To: <20040727105039.052352d8.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271442.33208.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.53.180] at Tue, 27 Jul 2004 13:42:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 13:50, Randy.Dunlap wrote:
>On Tue, 27 Jul 2004 14:02:59 -0400 Gene Heskett wrote:
>| On Tuesday 27 July 2004 13:32, Randy.Dunlap wrote:
>| [...]
>|
>| Gene Heskett wrote:
>| >| I take it that I should apply these to a 2.6.7 tarballs tree in
>| >| this order:
>| >| 1. 2.6.8-rc1
>| >|
>| >>>>> 2.6.8-rc2 <<<<<
>|
>| 2.6.8-rc2?  These patches I got will need to be reverted then?
>
>Nope, my bad.  I didn't read $Subject... please continue....
>
Humm, I just tried to build it using 2.6.8-rc1 as the main patch to 
2.6.7, but then the 2.6.8-rc2-bk3 patch will not apply as the second 
patch...  I'll go back and redo the rc2 patch first.  Or do I really 
have something totally fubared?

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
