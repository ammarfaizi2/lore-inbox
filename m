Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313022AbSDYKFY>; Thu, 25 Apr 2002 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313025AbSDYKFX>; Thu, 25 Apr 2002 06:05:23 -0400
Received: from ns.suse.de ([213.95.15.193]:46084 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313022AbSDYKFX>;
	Thu, 25 Apr 2002 06:05:23 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc 3.1 breaks wchan
In-Reply-To: <200204250528.g3P5SHo462311@saturn.cs.uml.edu>
X-Yow: TONY RANDALL!  Is YOUR life a PATIO of FUN??
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 25 Apr 2002 12:05:20 +0200
Message-ID: <jeg01k14bj.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

|> The compiler's
|> inability to inline something ought to be an error as well. Oh well.

-Winline -Werror

d&h, Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
