Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbUBKXnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbUBKXnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 18:43:50 -0500
Received: from prin.lo2.opole.pl ([213.77.100.98]:5391 "EHLO prin.lo2.opole.pl")
	by vger.kernel.org with ESMTP id S265728AbUBKXnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 18:43:49 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.2.0
Date: Thu, 12 Feb 2004 00:40:41 +0100
User-Agent: KMail/1.5
References: <200402112339.55593.mmazur@kernel.pl> <20040211232829.GA15450@codepoet.org>
In-Reply-To: <20040211232829.GA15450@codepoet.org>
Cc: Erik Andersen <andersen@codepoet.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200402120040.41527.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 of February 2004 00:28, Erik Andersen wrote:
> Thoughts on adding sanitized include/scsi/ ?

Yes. 
[mmazur@home mmazur]$ rpm -qf /usr/include/scsi
glibc-devel-2.3.2-14
:)

> linux/include/asm-mips/user.h includes asm/reg.h
> but there is no linux/include/asm-mips/reg.h....

Added to todo.


-- 
Ka¿dy cz³owiek, który naprawdê ¿yje, nie ma charakteru, nie mo¿e go mieæ.
Charakter jest zawsze martwy, otacza ciê zgni³a struktura przeniesiona z 
przesz³o¶ci. Je¿eli dzia³asz zgodnie z charakterem wtedy nie dzia³asz w ogóle
- jedynie mechanicznie reagujesz.                 { Osho }
