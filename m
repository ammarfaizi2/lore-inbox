Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbTIKTLT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 15:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbTIKTLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 15:11:19 -0400
Received: from outbound04.telus.net ([199.185.220.223]:34959 "EHLO
	priv-edtnes16-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S261468AbTIKTLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 15:11:18 -0400
Message-ID: <001401c37898$78d47ee0$5d74ad8e@hyperwolf>
From: "Eric Bickle" <ebickle@healthspace.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Problem: IDE data corruption with VIA chipsets on2.4.20-19.8+others
Date: Thu, 11 Sep 2003 12:11:15 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Other than to tell you Linux is simply reporting back what the drive
> itself reported - which is a physical failure to recover a sector of
> data no.
>
> A test that rewrites such a sector will generally clear the error, its
> one of the problems of some diagnostic tools. A pure read test should
> fine the error again unless its something like overheat causing the
> problem. SMART data will tell you drive temperatures


Thanks for the info, I'll try to dig up some better diagnostic tools. I
definately appreciate the quick response!

Thanks again,
-Eric Bickle

