Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVCPUIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVCPUIT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 15:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVCPUIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 15:08:19 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:52700 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262777AbVCPUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 15:08:13 -0500
Subject: Re: [BK PATCH] SCSI updates for 2.6.11
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42387C7C.9040407@pobox.com>
References: <1110934411.5685.39.camel@mulgrave> <42387C7C.9040407@pobox.com>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 15:07:59 -0500
Message-Id: <1111003679.5635.3.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-16 at 13:35 -0500, Jeff Garzik wrote:
> Are my 3ware bugfixes in the queue?  Currently 3ware claims it handled 
> the interrupt, even the interrupt is a shared one and the event was 
> meant for another driver.

Not in my queue ... you could try Adam Radford directly ...

James


