Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbSLIXlf>; Mon, 9 Dec 2002 18:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbSLIXlf>; Mon, 9 Dec 2002 18:41:35 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:63677 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266353AbSLIXle>; Mon, 9 Dec 2002 18:41:34 -0500
Subject: Re: 2.4.20-ac1 hangs IBM Thinkpad
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lukas Ruf <ruf@rawip.org>
Cc: Linux Kernel ml <linux-kernel@vger.kernel.org>
In-Reply-To: <20021209213453.GJ28720@maremma.ch>
References: <20021209213453.GJ28720@maremma.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 00:26:00 +0000
Message-Id: <1039479960.12051.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 21:34, Lukas Ruf wrote:
> Dear all,
> 
> 2.4.20-ac1 has hung my Laptop several times.  May this be due to the
> ATA-problem I found emails for in the archive?

More likely to be something else. You'd get dumps from IDE problems, and
the thinkpad IDE is PIIX which is very well tested. Could well be a
.20-ac1 bug or a .20 bug though  is vanilla 2.4.20 fine ?

