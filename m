Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSE3PLH>; Thu, 30 May 2002 11:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSE3PLG>; Thu, 30 May 2002 11:11:06 -0400
Received: from port-213-20-228-54.reverse.qdsl-home.de ([213.20.228.54]:12814
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S316682AbSE3PLB> convert rfc822-to-8bit; Thu, 30 May 2002 11:11:01 -0400
Date: Thu, 30 May 2002 17:09:48 +0200 (CEST)
Message-Id: <20020530.170948.846933988.rene.rebe@gmx.net>
To: dalecki@evision-ventures.com
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <3CF630A5.40002@evision-ventures.com>
X-Mailer: Mew version 2.2 on XEmacs 21.4.7 (Economic Science)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On: Thu, 30 May 2002 16:01:09 +0200,
    Martin Dalecki <dalecki@evision-ventures.com> wrote:

> Well somehow I have partly to agree. But however having a way to
> exclude network devices from mounting during mount -a is *very* usefull,

mount -a -t nonfs,nocoda,noproc,nodevfs,noshm"

Ever worked for me ...

k33p h4ck1n6
  René

--  
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)
e-mail:   rene.rebe@gmx.net, rene@rocklinux.org
web:      www.rocklinux.org, drocklinux.dyndns.org/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
