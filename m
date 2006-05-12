Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWELPWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWELPWP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWELPWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:22:15 -0400
Received: from smtp12.clb.oleane.net ([213.56.31.47]:45715 "EHLO
	smtp12.clb.oleane.net") by vger.kernel.org with ESMTP
	id S932128AbWELPWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:22:13 -0400
Message-ID: <4464A819.2050706@gmail.com>
Date: Fri, 12 May 2006 17:22:01 +0200
From: "sej.kernel" <sej.kernel@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mlock into kernel module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I need to use mlock and munlock function into a kernel module. How so
I call this system call from my module ?
I need to do this because I must use mlock in my software, but I can't
use root or suser to start it. So mlock alwaays fail.
Regards,
sej
