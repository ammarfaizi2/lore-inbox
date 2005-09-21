Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVIUWvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVIUWvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 18:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVIUWvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 18:51:42 -0400
Received: from dvhart.com ([64.146.134.43]:5000 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S965067AbVIUWvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 18:51:42 -0400
Date: Wed, 21 Sep 2005 15:51:38 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux v2.6.14-rc2
Message-ID: <721080000.1127343098@flay>
In-Reply-To: <646410000.1127258026@flay>
References: <Pine.LNX.4.58.0509192003410.2553@g5.osdl.org> <635500000.1127257400@flay> <1127257922.5589.43.camel@mulgrave> <646410000.1127258026@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Tuesday, September 20, 2005 16:13:46 -0700 "Martin J. Bligh" <mbligh@mbligh.org> wrote:

> 
> 
> --On Tuesday, September 20, 2005 18:12:02 -0500 James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
>> On Tue, 2005-09-20 at 16:03 -0700, Martin J. Bligh wrote:
>>> SCSI is broken in several cases by a lack of the patch below, which means 
>>> some of the regular test boxes can't - James, any chance of getting that
>>> one upstream? (it's cut and pasted, but then you wouldn't want to apply
>>> it anyway without correct "flow" ;-)).
>> 
>> It already is ... unfortunately just after 2.6.14-rc2, but if you use
>> the latest git head you should get it.
> 
> Spiffy - it should catch that tonight then ...

Works. Thanks,

M.

