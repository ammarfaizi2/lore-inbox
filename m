Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSLIOQk>; Mon, 9 Dec 2002 09:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbSLIOQj>; Mon, 9 Dec 2002 09:16:39 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:9404 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265581AbSLIOQK>; Mon, 9 Dec 2002 09:16:10 -0500
Subject: Re: 2.5.50-ac1 mpparse -> gcc 3.0.1 segfault
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Knop <w_knop@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <F32fiSBtAM9r5h1inen000214bb@hotmail.com>
References: <F32fiSBtAM9r5h1inen000214bb@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Dec 2002 15:00:25 +0000
Message-Id: <1039446025.10475.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need gcc 3.1.x to build 2.5.5x - you hit a compiler bug. With later
3.0.x you hit more insidious bugs in the compiler. 3.1.x/3.2 should be
fine

