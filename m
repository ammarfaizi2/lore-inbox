Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132966AbQKZXRH>; Sun, 26 Nov 2000 18:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131530AbQKZXQ5>; Sun, 26 Nov 2000 18:16:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19034 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S131338AbQKZXQn>; Sun, 26 Nov 2000 18:16:43 -0500
Subject: Re: [PATCH] modutils 2.3.20 and beyond
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Sun, 26 Nov 2000 22:46:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> from "Jeff V. Merkey" at Nov 26, 2000 04:36:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E140AZB-0002Qh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +		{"ignore-versions", 0, 0, 'i'},

I dont think we should encourage anyone to ignore symbol versions
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
