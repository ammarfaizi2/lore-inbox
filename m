Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSDYNYD>; Thu, 25 Apr 2002 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSDYNYD>; Thu, 25 Apr 2002 09:24:03 -0400
Received: from ns.suse.de ([213.95.15.193]:65036 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313122AbSDYNYC>;
	Thu, 25 Apr 2002 09:24:02 -0400
To: rajendra.mishra@timesys.com
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>, Nikita@Namesys.COM,
        Andrey Ulanov <drey@rt.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
In-Reply-To: <200204171440.JAA76065@tomcat.admin.navo.hpc.mil>
	<200204251310.g3PD9dI00738@localhost.localdomain>
X-Yow: Now I'm being INVOLUNTARILY shuffled closer to the CLAM DIP
 with the BROKEN PLASTIC FORKS in it!!
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 25 Apr 2002 15:22:54 +0200
Message-ID: <je8z7bzzdd.fsf@sykes.suse.de>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.2.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rpm <rajendra.mishra@timesys.com> writes:

|>    I understand that in case of inrrational number it will not give a exact 
|> value ......but division like 1/.2 is not irrational ! and it should always 
|> come to 5 !

It is not about irrational number (of course, the result of dividing two
rational number is always a rational number), but about finite precision.
You simply cannot represent 0.2 finitely in base 2.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE GmbH, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
