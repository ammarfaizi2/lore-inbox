Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSDMUAC>; Sat, 13 Apr 2002 16:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310470AbSDMUAB>; Sat, 13 Apr 2002 16:00:01 -0400
Received: from Ptrillia.EUnet.sk ([193.87.242.40]:3456 "EHLO meduna.org")
	by vger.kernel.org with ESMTP id <S310468AbSDMUAA>;
	Sat, 13 Apr 2002 16:00:00 -0400
From: Stanislav Meduna <stano@meduna.org>
Message-Id: <200204131841.g3DIfH401783@meduna.org>
Subject: Re: [Linux-usb-users] Re: uhci locks up in 2.4.19-pre6
To: johannes@erdfelt.com (Johannes Erdfelt)
Date: Sat, 13 Apr 2002 20:41:17 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
In-Reply-To: <20020413121522.A8314@sventech.com> from "Johannes Erdfelt" at apr 13, 2002 12:15:22
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Apply these patches. They should be in -pre7 (or -rc1, depending on what
> Marcelo calls it).
> 
> This should fix all outstanding lockups and performance problems with
> uhci.c. Let me know how it goes for you.

Yup, seems to work now and printing is back to normal too. Thanks.

Regards
-- 
                                   Stano

