Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTKAAsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 19:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTKAAsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 19:48:05 -0500
Received: from sea2-dav35.sea2.hotmail.com ([207.68.164.92]:43022 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262106AbTKAAsD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 19:48:03 -0500
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: pthread mutex question
Date: Fri, 31 Oct 2003 16:43:14 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV35RuMrzpeSK0000db71@hotmail.com>
X-OriginalArrivalTime: 01 Nov 2003 00:48:02.0625 (UTC) FILETIME=[CDECEB10:01C3A011]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am looking for an idea as to how to implement timed mutex using pthread
libraries on linux.
Basically I want to associate a timeout value with the wait function i,e
pthread_mutex_lock() which returns once the timeout expires instaed of
waiting for ever.
Pls help

thx..

Sankarshana M
