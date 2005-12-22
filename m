Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbVLVQyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbVLVQyM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 11:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVLVQyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 11:54:12 -0500
Received: from web34110.mail.mud.yahoo.com ([66.163.178.108]:50560 "HELO
	web34110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965171AbVLVQyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 11:54:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=m8K+Pd9sm8GMkQdhJ0JLBtExHHxJHvP8/sPU7c4ixwxGqiDmA18/FUVGBFlSsGNe34BCSsn/0AIavthGfcO0ALL8kEVMmIrk/SGld9rtRP/tIEv/V0bjWU+Y+0vbPiDqnj4UYkSM8BZpWnmoBQFn47t7rGGuq+5Mx9mrgdEPB08=  ;
Message-ID: <20051222165410.66134.qmail@web34110.mail.mud.yahoo.com>
Date: Thu, 22 Dec 2005 08:54:10 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: RE: scsi errors with dpt-i2o driver
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01FB3AC6@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Salyzyn, Mark" <mark_salyzyn@adaptec.com> wrote:

> These are issues being reported by the firmware in the adapter, looks
> like you have a bad drive. Since the adapter 'hides' the physical
> devices behind arrays. The array associated with id 9 is whining, but I
> do not know which physical is being naughty.
> 
> A driver change will make no difference, use the management applications
> to discover which target is misbehaving, probably would not hurt to
> contact Adaptec technical support, especially if you have an
> incompatible drive (often can be fixed by a firmware update to the
> drive). They also can help you through the cookbook discovery of cable
> and setting issues.
> 
> Sincerely -- Mark Salyzyn

Thanks for the reply, we will check the disks.  Why would a faulty disk hang the entire system for
such a long time?

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
