Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136348AbRD2Uin>; Sun, 29 Apr 2001 16:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136351AbRD2Uid>; Sun, 29 Apr 2001 16:38:33 -0400
Received: from www.topmail.de ([212.255.16.226]:63471 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S136348AbRD2Ui2>;
	Sun, 29 Apr 2001 16:38:28 -0400
Message-ID: <002401c0d0ec$57b84fd0$f6e3e13e@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "H. Peter Anvin" <hpa@transmeta.com>,
        "Rogier Wolff" <R.E.Wolff@BitWizard.nl>
Cc: "Gregory Maxwell" <greg@linuxpower.cx>,
        "Rogier Wolff" <R.E.Wolff@BitWizard.nl>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <200104292027.WAA25283@cave.bitwizard.nl>
Subject: Re: Sony Memory stick format funnies...
Date: Sun, 29 Apr 2001 20:37:51 -0000
Organization: eccesys.net Linux development
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, the root dir contains 512 entries.
Just from the dump.
(I would let the partition start at sector ptabl+1, not wasting
so much space... but M$ fdisk.exe neither does.)
-mirabilos

