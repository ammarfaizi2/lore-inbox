Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTJNSog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTJNSnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:43:19 -0400
Received: from sea2-dav13.sea2.hotmail.com ([207.68.164.117]:4615 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262909AbTJNSmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:42:33 -0400
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question on atomic_inc/dec
Date: Tue, 14 Oct 2003 11:38:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV139jKikEe6Q00002ae5@hotmail.com>
X-OriginalArrivalTime: 14 Oct 2003 18:42:33.0085 (UTC) FILETIME=[EDE0EAD0:01C39282]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have a question concerning the macro atomic_inc on REDHAT 9.0. I had used
atomic_inc on REDHAT 7.2 earlier. I installed redhat 9.0 and tried to run my
old code on this. I got the error saying atomic_inc not declared.

I tried to search the header file in which this is defined but with failure.

If any of u guys know about this problem pls help me ...

thx in advance
Sankarshana M
