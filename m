Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266360AbRGFKhd>; Fri, 6 Jul 2001 06:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266361AbRGFKhX>; Fri, 6 Jul 2001 06:37:23 -0400
Received: from vulcan.datanet.hu ([194.149.0.156]:63369 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S266360AbRGFKhL>;
	Fri, 6 Jul 2001 06:37:11 -0400
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: =?ISO-8859-2?Q?Datakart_Geodzia_KFT.?=
To: Krzysztof Rusocki <kszysiu@braxis.co.uk>
Date: Fri, 6 Jul 2001 12:36:18 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] hgafb.c as module (unresolved symbol) 2.4.6+
CC: linux-kernel@vger.kernel.org
Message-ID: <3B45B0DD.18769.2855EA38@localhost>
In-Reply-To: <20010706122520.A22693@main.braxis.co.uk>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Krzysztof Rusocki <kszysiu@braxis.co.uk> wrote:

> As far as i noticed - since 2.4.6
> there should be defined
> 
> #define INCLUDE_LINUX_LOGO_DATA
> 
> instead of
> 
> #define INCLUDE_LINUX_LOGOBW
> 
> otherwise linux logos do not get included and unresolved symbol occures
> patch against 2.4.7-pre{1,2,3} attached, which afaik also applies for 2.4.6

Your patch is right, it is already included in the ac-tree.

Best regards:
	Ferenc Bakonyi

