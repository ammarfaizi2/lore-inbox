Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbSKCMKR>; Sun, 3 Nov 2002 07:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSKCMKR>; Sun, 3 Nov 2002 07:10:17 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:19852 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261855AbSKCMKQ>; Sun, 3 Nov 2002 07:10:16 -0500
Subject: Re: [PATCH] Dead code in i386 math-emu
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DC49ABE.2020801@quark.didntduck.org>
References: <3DC49ABE.2020801@quark.didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:37:53 +0000
Message-Id: <1036327073.29646.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 03:40, Brian Gerst wrote:
> This removes unused non-reentrant code in the fpu emulator.

Why remove it - it might actually be useful some day and its doing no
harm ?

