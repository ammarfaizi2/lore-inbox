Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282392AbRLMJ4m>; Thu, 13 Dec 2001 04:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282378AbRLMJ4f>; Thu, 13 Dec 2001 04:56:35 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:20470 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S282190AbRLMJ42>; Thu, 13 Dec 2001 04:56:28 -0500
From: David Lang <david.lang@digitalinsight.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Date: Thu, 13 Dec 2001 01:30:53 -0800 (PST)
Subject: Re: CML2 1.9.8
In-Reply-To: <20011213040637.A9104@thyrsus.com>
Message-ID: <Pine.LNX.4.40.0112130130120.7706-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does this problem (and fix) also apply to the adventure mode (just
checking to see how unified the output section really is :-)

David Lang

On Thu, 13 Dec 2001, Eric S. Raymond wrote:

> Date: Thu, 13 Dec 2001 04:06:37 -0500
> From: Eric S. Raymond <esr@thyrsus.com>
> To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
> Subject: CML2 1.9.8
>
> The latest version is always available at http://www.tuxedo.org/~esr/cml2/
>
> Release 1.9.8: Thu Dec 13 03:52:38 EST 2001
> 	* Rulebase and help sync with 2.4.17-pre8/2.5.1-pre11.
> 	* Saveability predicate simplified drastically.
>
> This is a point release intended for Keith Owens to test.  He has
> reported a bug that different front ends save out different sets of symbols
> set to n; all the variants are logically equivalent, so this is strictly
> speaking only a cosmetic bug.  This release attempts to fix the problem by
> simplifying the code that determines whether a symbol is eligible to be
> saved out.
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> The people cannot delegate to government the power to do anything
> which would be unlawful for them to do themselves.
> 	-- John Locke, "A Treatise Concerning Civil Government"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
