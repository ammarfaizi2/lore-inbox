Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbVL0QDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbVL0QDw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 11:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVL0QDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 11:03:52 -0500
Received: from ns.dynamicweb.hu ([195.228.155.139]:62674 "EHLO dynamicweb.hu")
	by vger.kernel.org with ESMTP id S932223AbVL0QDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 11:03:51 -0500
Message-ID: <118101c60afe$437cef70$a700a8c0@dcccs>
From: "JaniD++" <djani22@dynamicweb.hu>
To: <linux-kernel@vger.kernel.org>
Subject: ata2: status=0x51 {
Date: Tue, 27 Dec 2005 16:57:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list,

I can catch this with netconsole:

Dec 27 01:58:46 st-0001 ata2: status=0x51 {
Dec 27 01:58:46 st-0001 DriveReady
Dec 27 01:58:46 st-0001 SeekComplete
Dec 27 01:58:46 st-0001 Error

Only this is in log.
After this message, the system hangs, and only reset can help. (no ping,
ssh)

This happened in second time.

kernel: 2.6.14.2

Cheers,
Janos


