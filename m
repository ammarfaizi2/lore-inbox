Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282845AbRLVWWR>; Sat, 22 Dec 2001 17:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282860AbRLVWWH>; Sat, 22 Dec 2001 17:22:07 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:2829 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S282845AbRLVWVz>;
	Sat, 22 Dec 2001 17:21:55 -0500
Date: Sat, 22 Dec 2001 23:21:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: mirabilos {Thorsten Glaser} <mirabilos@netcologne.de>
Cc: Dirk Moerenhout <dirk@staf.planetinternet.be>,
        Jeff Mcadams <jeffm@iglou.com>, linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.hel p.
Message-ID: <20011222232152.A11373@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0112221538560.214-100000@dirk> <011701c18b10$329ef3a0$30d8fea9@ecce>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <011701c18b10$329ef3a0$30d8fea9@ecce>; from mirabilos@netcologne.de on Sat, Dec 22, 2001 at 05:43:41PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 05:43:41PM -0000, mirabilos {Thorsten Glaser} wrote:
> > So in general your best bet is to see 1Kb/s as 1.000 bits per second
> and
> > 1Mb/s as 1000Kb/s or 1.000.000b/s. As most technologies will stick to
> > that. Though off course through the ages a lot of things have been
> altered
> > it and therefor have added to the confusion.
> 
> I'd rather think of 1 kpbs than 1 Kbps...
> K is Kelvin, and nothing else (IIRC). K is no prefix.

Some time ago, k was 1000 and K was 1024, b was bits and B was bytes ...
but then came the mega and giga, and you can't uppercase those ...

> 
> My proposal: humans should start using sedecimal as
> primary numbering system. (And forget about octal
> as fast as possible - it is referred way too often in UNIX!)
> 
> Greetings from snowful Bonn (Rhein)
> -mirabilos
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
