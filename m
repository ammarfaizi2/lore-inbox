Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289555AbSAONCW>; Tue, 15 Jan 2002 08:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289559AbSAONCM>; Tue, 15 Jan 2002 08:02:12 -0500
Received: from jalon.able.es ([212.97.163.2]:56268 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289555AbSAONCC>;
	Tue, 15 Jan 2002 08:02:02 -0500
Date: Tue, 15 Jan 2002 11:32:13 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020115113213.A1539@werewolf.able.es>
In-Reply-To: <20020114212550.A17323@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020114212550.A17323@animx.eu.org>; from wakko@animx.eu.org on mar, ene 15, 2002 at 03:25:50 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020115 Wakko Warner wrote:
>arch/alpha/kernel/kernel.o(.exitcall.exit+0x0): undefined reference to `local symbols in discarded section .text.exit'

Too bew binutils. .17 works again.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre3-beo #5 SMP Sun Jan 13 02:14:04 CET 2002 i686
