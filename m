Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUDEPGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 11:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDEPGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 11:06:49 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:18048 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262719AbUDEPGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 11:06:48 -0400
Message-ID: <000401c41b1f$d2cf65c0$1530a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: "Wakko Warner" <wakko@animx.eu.org>
Cc: <linux-kernel@vger.kernel.org>
References: <003301c41b18$38ff7f90$1530a8c0@HUSH> <20040405110541.B22980@animx.eu.org>
Subject: Re: 3com issues in 2.6.5
Date: Mon, 5 Apr 2004 17:08:16 +0200
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

> > module with both interfaces up, but obviously as soon as I do that they
> > dissapear - I assume this is the intended 2.6 behaviour).
>
> Let me ask you, are you noticing slowness sending or receiving?  I'm
having

Yes, this is why I started to look at the problem.
(slow as in 100 kb/s in a 100 Mbit/s LAN).

