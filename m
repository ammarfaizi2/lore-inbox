Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131244AbREHKL5>; Tue, 8 May 2001 06:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbREHKLr>; Tue, 8 May 2001 06:11:47 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:28677 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131244AbREHKLe>;
	Tue, 8 May 2001 06:11:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Ben Castricum" <benc@inet.kpn.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-pre1 Unresolved symbol in module ide-mod.o 
In-Reply-To: Your message of "Tue, 08 May 2001 11:07:38 +0200."
             <000701c0d79e$667dd0e0$a10616c2@nmcgv> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 May 2001 20:11:25 +1000
Message-ID: <21647.989316685@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001 11:07:38 +0200, 
"Ben Castricum" <benc@inet.kpn.net> wrote:
>root@spike:~# depmod -ae 2.4.5-pre1
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.5-pre1/kernel/drivers/ide/ide-mod.o
>depmod:         invalidate_device_R25a4b0b2

Try http://www.tux.org/lkml/#s8-8

