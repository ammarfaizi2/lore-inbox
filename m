Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282129AbRLHQ2d>; Sat, 8 Dec 2001 11:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282149AbRLHQ2X>; Sat, 8 Dec 2001 11:28:23 -0500
Received: from yuha.menta.net ([212.78.128.42]:4093 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S282129AbRLHQ2O>;
	Sat, 8 Dec 2001 11:28:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: "Pantelis Proios" <pproios@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory Interleave + kernel + VIA chipsets == possible ?
Date: Sat, 8 Dec 2001 17:27:42 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <F760JPzw2O8Z9B5un770001e64e@hotmail.com> <01120816555700.01330@localhost.localdomain>
In-Reply-To: <01120816555700.01330@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <01120817274200.01202@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here is the url where these tweaks are:
http://viahardware.com/memtweakguide1.shtm

basically to enable em registers (offsets) 50 & 51 should go to FF hex, regs 
64 to 67 should go to 12 hex and reg 68 should go to 43 hex
