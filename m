Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTHYON2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 10:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261940AbTHYON2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 10:13:28 -0400
Received: from [66.46.160.122] ([66.46.160.122]:23310 "EHLO
	sc-fw.superclick.com") by vger.kernel.org with ESMTP
	id S261869AbTHYONY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 10:13:24 -0400
From: "Enrico Demarin" <enricod@videotron.ca>
To: <linux-kernel@vger.kernel.org>
Subject: RE: linux-2.4.22 released
Date: Mon, 25 Aug 2003 10:11:28 +0200
Message-ID: <002601c36ae0$7c247b10$0440a8c0@SC2003002>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-reply-to: <200308251148.h7PBmU8B027700@hera.kernel.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible that linux-2.4.22 broke SO_ORIGINAL_DST API ? 


I used to run a transparent HTTP proxy but no go with 2.4.22 : 


I get "getsockopt(SO_ORIGINAL_DST): No such file or directory"

- Enrico

