Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSKDX6F>; Mon, 4 Nov 2002 18:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSKDX6E>; Mon, 4 Nov 2002 18:58:04 -0500
Received: from fmr01.intel.com ([192.55.52.18]:8902 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S263105AbSKDX6D>;
	Mon, 4 Nov 2002 18:58:03 -0500
Message-ID: <00fd01c2845e$eb407ee0$7fd40a0a@amr.corp.intel.com>
From: "Geoff Gustafson" <geoff@linux.co.intel.com>
To: "Dan Kegel" <dkegel@ixiacom.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <sglass@us.ibm.com>
References: <3DC702E1.1050306@ixiacom.com>
Subject: Re: [ANNOUNCE] Open POSIX Test Suite
Date: Mon, 4 Nov 2002 16:04:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You are about to duplicate http://ltp.sf.net

My understanding is that LTP is focused on current mainline kernel testing,
while this project's initial concern is areas that are not currently in Linux
like POSIX message queues, semaphores, and full support for POSIX threads. I see
this as being used to evaluate different implementations that are being
considered for inclusion in the kernel, glibc, etc.

This project is concerned with the POSIX APIs regardless of where they are
implemented (kernel, glibc, etc.). Thus it can focus on POSIX, independent of
implementation. This project will be more concerned with traceability back to
the POSIX specification, and completeness of coverage, than I would expect from
LTP.

That said, there is some overlap, and an exchange of test cases between the
projects may be very useful.

I've copied Stephanie from LTP to get her reaction.

-- Geoff Gustafson

These are my views and not necessarily those of my employer.

