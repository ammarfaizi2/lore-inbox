Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281849AbRKRD7U>; Sat, 17 Nov 2001 22:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281850AbRKRD7J>; Sat, 17 Nov 2001 22:59:09 -0500
Received: from mta3.fibertel.com.ar ([24.232.0.163]:58285 "EHLO
	mail.fibertel.com.ar") by vger.kernel.org with ESMTP
	id <S281849AbRKRD7F>; Sat, 17 Nov 2001 22:59:05 -0500
Message-ID: <003a01c16fe5$088ae9c0$0200000a@home>
From: "Norberto Bensa" <nbensa@yahoo.com>
To: <linux-kernel@vger.kernel.org>
Subject: tmpfs?
Date: Sun, 18 Nov 2001 00:56:37 -0300
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

Hello,

I've configured my kernel (2.4.13-ac8) to use tmpfs, but it seems that it
only uses half my physical memory (64 of 128MB).

>From Configure/help
/*
    Tmpfs is a file system which keeps all files in virtual memory.

    In contrast to RAM disks, which get allocated a ficed aount of physical
RAM, tmps grows and shrinks to accommodate the files it contains and is able
to swap unneeded pages out to swap space.
*/

Well, it doesn't grows, neither shrinks, but maybe it's only me because I'm
a newbie with this. How does tmpfs works, and how do I configure it
correctly.

Thank you in advance,
Norberto


