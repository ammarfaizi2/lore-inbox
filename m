Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbRGYPgr>; Wed, 25 Jul 2001 11:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266997AbRGYPgi>; Wed, 25 Jul 2001 11:36:38 -0400
Received: from [24.229.53.66] ([24.229.53.66]:46854 "HELO
	bbserver1.backbonesecurity.com") by vger.kernel.org with SMTP
	id <S266989AbRGYPg1> convert rfc822-to-8bit; Wed, 25 Jul 2001 11:36:27 -0400
Subject: device struct
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Wed, 25 Jul 2001 11:44:59 -0400
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <94FD5825A793194CBF039E6673E9AFE0C017@bbserver1.backbonesecurity.com>
Thread-Topic: Athlon/MSI mobo combo broken?
Thread-Index: AcEVHst262Ws5pN2RvOR70tAxsqSRAAAJvRA
From: "David CM Weber" <dweber@backbonesecurity.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I'm looking at some old (circa v2.2.5 of the kernel) sample code,
referring to the networking system. It refers to a structure named
"device".  Was this replaced with something else?  

On a similar note, is there a "good" way of finding this data myself?
I've been using ctags, and this is of limited use. (Sometimes good,
sometimes bad).

Thanks for bearing with me,


Dave Weber
Backbone Security, Inc.
