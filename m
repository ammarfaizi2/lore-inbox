Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbSJ3AHg>; Tue, 29 Oct 2002 19:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262411AbSJ3AHg>; Tue, 29 Oct 2002 19:07:36 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:56837
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262107AbSJ3AHf>; Tue, 29 Oct 2002 19:07:35 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33C7B@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: what serial port type are Elan ports?
Date: Tue, 29 Oct 2002 16:13:52 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to know what UART type the serial driver detects for the two built-in
serial ports on the AMD Elan Microcontroller?

Would some nice person who has an Elan based system please send me the first
ten lines of the output of the following command?

	more /proc/tty/driver/serial

Thanks in advance,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

