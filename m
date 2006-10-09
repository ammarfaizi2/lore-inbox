Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWJIOiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWJIOiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbWJIOiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:38:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:20369 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751877AbWJIOiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:38:20 -0400
Message-ID: <452A5ED3.9020607@garzik.org>
Date: Mon, 09 Oct 2006 10:38:11 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fallout from alpha pt_regs patches
References: <20061009114652.GM29920@ftp.linux.org.uk>
In-Reply-To: <20061009114652.GM29920@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> missed irq handler in sys_titan and forgotten prototype update.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

ACK

Long live alpha!

	Jeff



