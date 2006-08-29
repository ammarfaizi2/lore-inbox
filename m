Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbWH2Ocl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbWH2Ocl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 10:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWH2Ocl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 10:32:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:55251 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964994AbWH2Ock (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 10:32:40 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: SDRAM or DDRAM in linux
To: Niklaus <niklaus@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 29 Aug 2006 16:30:46 +0200
References: <6P5Ty-4Qs-5@gated-at.bofh.it> <6P5Ty-4Qs-3@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GI4cN-0000mZ-10@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Niklaus <niklaus@gmail.com> wrote:

> 1) How do i find out when the machine is online , if it is SDRAM or
> DDRAM. I tried dmidecode utility but i was not sure about the type.
> Can someone help me out by pasting the output for both DDR and SDRAM
> in dmidecode or similar.

If I need to find out the mainboard chipset, I usurally look at the IDE
controler, and if you know the mb chipset, you can get the specs.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
