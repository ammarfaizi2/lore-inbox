Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286447AbSAOQqO>; Tue, 15 Jan 2002 11:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSAOQqE>; Tue, 15 Jan 2002 11:46:04 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:28294
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S286447AbSAOQpv>; Tue, 15 Jan 2002 11:45:51 -0500
Date: Tue, 15 Jan 2002 11:55:30 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to compile 2.4.14 on alpha
Message-ID: <20020115115530.A19073@animx.eu.org>
In-Reply-To: <20020114212550.A17323@animx.eu.org> <20020115113213.A1539@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20020115113213.A1539@werewolf.able.es>; from J.A. Magallon on Tue, Jan 15, 2002 at 11:32:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >arch/alpha/kernel/kernel.o(.exitcall.exit+0x0): undefined reference to `local symbols in discarded section .text.exit'
> 
> Too bew binutils. .17 works again.

Are you saying that 2.4.17 works but prior doesn't?  or were you refering to
binutils.

Please keep the CC to linux-kernel as my spam filter is tagging your mail
server =(

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
