Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVITXMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVITXMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 19:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVITXMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 19:12:13 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:48266 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1750791AbVITXMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 19:12:12 -0400
Subject: Re: Arrr! Linux v2.6.14-rc2
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <635500000.1127257400@flay>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org>
	 <635500000.1127257400@flay>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 18:12:02 -0500
Message-Id: <1127257922.5589.43.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-20 at 16:03 -0700, Martin J. Bligh wrote:
> SCSI is broken in several cases by a lack of the patch below, which means 
> some of the regular test boxes can't - James, any chance of getting that
> one upstream? (it's cut and pasted, but then you wouldn't want to apply
> it anyway without correct "flow" ;-)).

It already is ... unfortunately just after 2.6.14-rc2, but if you use
the latest git head you should get it.

James


