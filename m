Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422845AbWJUTZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422845AbWJUTZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 15:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWJUTZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 15:25:27 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:640 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422793AbWJUTZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 15:25:26 -0400
Message-ID: <453A7423.5080107@garzik.org>
Date: Sat, 21 Oct 2006 15:25:23 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: misha@fabric7.com
CC: KERNEL Linux <linux-kernel@vger.kernel.org>,
       NETDEV Linux <netdev@vger.kernel.org>,
       Sriram Chidambaram <schidambaram@fabric7.com>
Subject: Re: [PATCH] VIOC: Ethtool
References: <200610131056.28563.misha@fabric7.com>
In-Reply-To: <200610131056.28563.misha@fabric7.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Misha Tomushev wrote:
> The following is the ethtool patch for  VIOC Device Driver.
> 
> Signed-off-by: Misha Tomushev  <misha@fabric7.com>

ACK but does not apply to ethtool.git:


Applying 'add VIOC support'

Adds trailing whitespace.
.dotest/patch:50:#define VIOC_REGS_LINE_SIZE    sizeof(struct regs_line)
error: patch failed: Makefile.am:7
error: Makefile.am: patch does not apply
error: patch failed: ethtool-util.h:48
error: ethtool-util.h: patch does not apply
error: patch failed: ethtool.c:945
error: ethtool.c: patch does not apply

