Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265861AbTLIOSn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbTLIOSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:18:42 -0500
Received: from intra.cyclades.com ([64.186.161.6]:47781 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265861AbTLIOSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:18:39 -0500
Date: Tue, 9 Dec 2003 12:10:06 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Joe Thornber <thornber@sistina.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <20031209134551.GG472@reti>
Message-ID: <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Dec 2003, Joe Thornber wrote:

> On Tue, Dec 09, 2003 at 11:15:08AM -0200, Marcelo Tosatti wrote:
> > I believe 2.6 is the right place for the device mapper. 
> 
> So what's the difference between a new filesystem like XFS and a new
> device driver like dm ?

Expected question... 

XFS is a totally different filesystem from the ones present in 2.4. 

As far as I know, we already have the similar functionality in 2.4 with
LVM. Device mapper provides the same functionality but in a much cleaner
way. Is that right?

