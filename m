Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268452AbTBSNKt>; Wed, 19 Feb 2003 08:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268457AbTBSNKt>; Wed, 19 Feb 2003 08:10:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42891
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268452AbTBSNKt>; Wed, 19 Feb 2003 08:10:49 -0500
Subject: Re: [PATCH 2.4.21-pre4|BK] remove /proc/meminfo:MemShared
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200302191333.43875.m.c.p@wolk-project.de>
References: <200302191333.43875.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045664576.27427.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 14:22:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 12:42, Marc-Christian Petersen wrote:
> Hi Marcelo,
> 
> it seems to have been displaying zero for the past several years.

It was left in because some tools break if you remove it. For 2.5 its
much less of an issue.

