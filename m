Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267308AbUBSTM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUBSTM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:12:27 -0500
Received: from mx1.ews.uiuc.edu ([130.126.161.237]:44204 "EHLO
	mx1.ews.uiuc.edu") by vger.kernel.org with ESMTP id S267308AbUBSTM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:12:26 -0500
Message-ID: <009701c3f71c$4f177c30$e6f7ae80@ad.uiuc.edu>
From: "Wanghong Yuan" <wyuan1@ews.uiuc.edu>
To: <linux-kernel@vger.kernel.org>
Subject: How to add new system call in kernel 2.6
Date: Thu, 19 Feb 2004 13:12:25 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I built a kernel module, which provides some system calls for applications.
In kernel 2.4, the sys_call_table is exported, so I can hook system calls.
How I can add these system calls in kernel 2.6? Thanks and appreciate any
suggestion.

