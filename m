Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbREaWv6>; Thu, 31 May 2001 18:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263257AbREaWvk>; Thu, 31 May 2001 18:51:40 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53010 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263267AbREaWvf>; Thu, 31 May 2001 18:51:35 -0400
Subject: Re: 2.4.5 VM
To: vichu@digitalme.com (Trever L. Adams)
Date: Thu, 31 May 2001 23:49:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3B16C9A8.7090402@digitalme.com> from "Trever L. Adams" at May 31, 2001 06:46:00 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E155bG5-0008AX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My system has 128 Meg of Swap and RAM.

Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
with 2.4.

Marcelo is working to change that but right now you are running something 
explicitly explained as not going to work as you want

