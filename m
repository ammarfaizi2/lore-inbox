Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbSLEQqR>; Thu, 5 Dec 2002 11:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSLEQqR>; Thu, 5 Dec 2002 11:46:17 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:48808 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261900AbSLEQqQ>; Thu, 5 Dec 2002 11:46:16 -0500
Subject: Re: [warnings] [6/8] fix mismatched function type in
	arch/i386/kernel/ioapic.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wli@holomorphy.com
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net, rmk@arm.linux.org.uk,
       jgarzik@pobox.com, miura@da-cha.org, viro@math.psu.edu, pavel@ucw.cz
In-Reply-To: <0212050252.jbobndDcEaLdlb5bCcEaYaZb~akaFc3d20143@holomorphy.com>
References: <0212050252.jbobndDcEaLdlb5bCcEaYaZb~akaFc3d20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 17:28:05 +0000
Message-Id: <1039109285.19681.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 10:52, wli@holomorphy.com wrote:
> Change the function return type so as to match the required initcall
> prototype. Alan, this is yours to ack.

Already iny my tree - ack

