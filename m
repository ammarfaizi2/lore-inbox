Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319394AbSIEX1E>; Thu, 5 Sep 2002 19:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319395AbSIEX1D>; Thu, 5 Sep 2002 19:27:03 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:58864
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319394AbSIEX1D>; Thu, 5 Sep 2002 19:27:03 -0400
Subject: Re: [PATCH][2.4.20-pre5] non syscall gettimeofday
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net>
References: <1031267553.10830.71.camel@dell_ss3.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 00:32:35 +0100
Message-Id: <1031268755.7367.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That seems awfully heavy handed for TSC, as well as reducing your
accuracy massively. 

