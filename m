Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTIDO5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTIDO5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:57:48 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:25640 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S265200AbTIDO41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:56:27 -0400
Message-ID: <000801c372f4$a3d3a890$0c00a8c0@diemos>
From: "Paul Fulghum" <paulkf@microgate.com>
To: "John Levon" <levon@movementarian.org>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>
References: <1062685785.2181.5.camel@diemos> <20030904144332.GA26973@compsoc.man.ac.uk>
Subject: Re: [PATCH] synclinkmp.c 2.4.23-pre3
Date: Thu, 4 Sep 2003 09:55:53 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why is it wrapped inside #ifdef MODULE_LICENSE ? It's in current 2.4 and
> current 2.6, no ?

No.
It is not in all 2.4 versions.

I have to support customers for all versions of 2.4.

The ifdef allows me to have a single source file
that works for all versions of 2.4.

Paul Fulghum, paulkf@microgate.com
Microgate Corporation, www.microgate.com
