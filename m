Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSLCLLF>; Tue, 3 Dec 2002 06:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbSLCLLF>; Tue, 3 Dec 2002 06:11:05 -0500
Received: from [81.2.122.30] ([81.2.122.30]:3333 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266228AbSLCLLF>;
	Tue, 3 Dec 2002 06:11:05 -0500
Date: Tue, 3 Dec 2002 11:29:43 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200212031129.gB3BThpw000597@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Input core support required for non-USB joystick
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.4.20, (and possibly earlier versions, I haven't checked), it's necessary to enable input core support, before non-USB joystick support can be enabled.

I thought that input core support related to USB specifically, is that incorrect?

John.
