Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268402AbRHJOTj>; Fri, 10 Aug 2001 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268432AbRHJOT3>; Fri, 10 Aug 2001 10:19:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:8720 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268402AbRHJOTT>; Fri, 10 Aug 2001 10:19:19 -0400
Subject: Re: [PATCH] double DRM - fixes
To: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz)
Date: Fri, 10 Aug 2001 15:20:55 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list), faith@valinux.com,
        elenstev@mesatop.com
In-Reply-To: <no.id> from "Andrzej Krzysztofowicz" at Aug 10, 2001 03:33:01 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15VD9j-00013C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BTW: Alan, do you think it would be worth to be able to compile both versions
>      together (in the modular case) ?

it seems tricky to get right. Vendors are going to know which X they shipped
and end users build with the right DRM...
