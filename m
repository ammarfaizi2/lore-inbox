Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbTASVPa>; Sun, 19 Jan 2003 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTASVPa>; Sun, 19 Jan 2003 16:15:30 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:54435 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267690AbTASVP3>; Sun, 19 Jan 2003 16:15:29 -0500
Message-ID: <000a01c2c001$2706c2d0$c5eeea0c@attbi.com>
From: "Paul Zimmerman" <zimmerman.paul@attbi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: ANN: LKMB (Linux Kernel Module Builder) version 0.1.16
Date: Sun, 19 Jan 2003 13:24:29 -0800
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

> Try "make modules INSTALL_MOD_PATH=<whatever>".

Oops, that should have been:

"make modules_install INSTALL_MOD_PATH=<whatever>"

Paul


