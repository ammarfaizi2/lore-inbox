Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273445AbRINSzE>; Fri, 14 Sep 2001 14:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273446AbRINSyz>; Fri, 14 Sep 2001 14:54:55 -0400
Received: from ns.suse.de ([213.95.15.193]:6419 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S273445AbRINSyq> convert rfc822-to-8bit;
	Fri, 14 Sep 2001 14:54:46 -0400
To: Alexander Stohr <AlexanderS@ati.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre9 min/max raises "const" warnings
In-Reply-To: <761E23C7F09AD51188990008C74C26141221@fgl00exh01.atitech.com>
X-Yow: This PIZZA symbolizes my COMPLETE EMOTIONAL RECOVERY!!
From: Andreas Schwab <schwab@suse.de>
Date: 14 Sep 2001 20:55:08 +0200
In-Reply-To: <761E23C7F09AD51188990008C74C26141221@fgl00exh01.atitech.com> (Alexander Stohr's message of "Fri, 14 Sep 2001 19:55:35 +0200")
Message-ID: <jeelp9vbzn.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Stohr <AlexanderS@ati.com> writes:

|> i am yet not sure if the used "? :" operator set does qualify as
|> a left-value.

For Standard C it isn't, but for GNU C it is.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
