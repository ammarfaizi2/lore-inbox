Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVCWHSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVCWHSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCWHSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:18:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25769 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262838AbVCWHSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:18:05 -0500
Date: Wed, 23 Mar 2005 08:17:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "shafa.hidee" <shafa.hidee@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Redirecting output
In-Reply-To: <001e01c52f74$2f27daa0$6a88cb0a@hss.hns.com>
Message-ID: <Pine.LNX.4.61.0503230816440.21578@yvahk01.tjqt.qr>
References: <001e01c52f74$2f27daa0$6a88cb0a@hss.hns.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,
>     I have created a dummy module for learning device driver in linux. I
>want to redirect the standard output of printk to my xterm. But by default
>it is redirected to tty.

What shall happen if you close the pts of the xterm?



Jan Engelhardt
-- 
