Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbUBZJF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 04:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbUBZJF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 04:05:56 -0500
Received: from [152.101.81.89] ([152.101.81.89]:20750 "HELO southa.com")
	by vger.kernel.org with SMTP id S262740AbUBZJFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 04:05:54 -0500
Message-ID: <03cd01c3fc48$eea15060$9c02a8c0@southa.com>
From: "Kyle Wong" <kylewong@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec 1210SA SATA Controller Performance
Date: Thu, 26 Feb 2004 17:14:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

as I know, the kernel limit the raid reconstuction speed to 10MB/s, check
/proc/sys/dev/raid/speed_limit_max and echo something like bigger into it.

Kyle





