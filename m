Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268189AbUI2Erd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268189AbUI2Erd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 00:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268199AbUI2Erd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 00:47:33 -0400
Received: from [220.225.128.84] ([220.225.128.84]:65511 "HELO
	mail.gdatech.co.in") by vger.kernel.org with SMTP id S268189AbUI2Erc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 00:47:32 -0400
Message-ID: <006001c4a5df$ad605c40$8200a8c0@RakeshJagota>
From: "Rakesh Jagota" <j.rakesh@gdatech.co.in>
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>
References: <4159E85A.6080806@ammasso.com>
Subject: opening a file inside the kernel module
Date: Wed, 29 Sep 2004 10:19:17 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am working in linux, i would like to know abt whether can I open a file
inside the kernel module without using any application. If so how how the
files_struct will be maintained. Does a kernel module has this struct?

Waiting for any suggestion from the list.

Thanks in advance,
rakesh

