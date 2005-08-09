Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVHIO7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVHIO7n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbVHIO7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:59:43 -0400
Received: from dvhart.com ([64.146.134.43]:42881 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964814AbVHIO7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:59:41 -0400
Date: Tue, 09 Aug 2005 07:59:42 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       bugme-daemon@kernel-bugs.osdl.org
Subject: Re: [Bugme-new] [Bug 5003] New: Problem with symbios driver	on	recent	-mm trees
Message-ID: <531000000.1123599581@[10.10.2.4]>
In-Reply-To: <1123597604.5170.10.camel@mulgrave>
References: <135040000.1123216397@[10.10.2.4]> <20050804233927.2d3abb16.akpm@osdl.org> <1123251892.5003.6.camel@mulgrave> <179280000.1123252564@[10.10.2.4]> <1123254086.5003.10.camel@mulgrave> <453380000.1123562466@[10.10.2.4]> <1123597604.5170.10.camel@mulgrave>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--James Bottomley <James.Bottomley@SteelEye.com> wrote (on Tuesday, August 09, 2005 09:26:44 -0500):

> On Mon, 2005-08-08 at 21:41 -0700, Martin J. Bligh wrote:
>> Nope, is the same as before with this patch ....
> 
> Dear novice bug reporter,
> 
> Thank you for taking the trouble to test this.  Unfortunately, without
> any dmesg output, it's rather hard to tell what's going on here.  Would
> you be so kind as to send this information so we can try to diagnose
> what's going on.

Dear novice test examiner,

It's in http://test.kernel.org with everything else ;-)
2.6.13-rc4-mm1+jejb_fix ... drills down to:

http://test.kernel.org/10080/debug/console.log

M.

