Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129732AbQLOSXi>; Fri, 15 Dec 2000 13:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQLOSX2>; Fri, 15 Dec 2000 13:23:28 -0500
Received: from terminus.zytor.com ([209.10.217.84]:59655 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S129732AbQLOSXR>; Fri, 15 Dec 2000 13:23:17 -0500
Message-ID: <1368.195.67.189.102.976902742.squirrel@www.zytor.com>
Date: Fri, 15 Dec 2000 09:52:22 -0800 (PST)
Subject: Re: test12 lockups -- need feedback
From: "H. Peter Anvin" <hpa@zytor.com>
To: ingo.oeser@informatik.tu-chemnitz.de
In-Reply-To: <20001215194735.K829@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20001215194735.K829@nightmaster.csn.tu-chemnitz.de>
Cc: e.jokisch@u-code.de, linux-kernel@vger.kernel.org, davej@suse.de,
        hpa@zytor.com
X-Mailer: SquirrelMail (version 0.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have no Realtek-Card and have the same lockup.
> 
> I also got a hard lockup (but with Oops) while calling the
> "vendor CPU init" function during system boot.
> 
> This was on Cyrix III.
> 
> PS: CC'ed hpa, because he is cpu-detection maintainer and davej,
>    because he added Cyrix III support and might know details ;-)
> 

Please include the oops information, as well as the /proc/cpuinfo output.

    -hpa


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
