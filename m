Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288516AbSADHDn>; Fri, 4 Jan 2002 02:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288515AbSADHDd>; Fri, 4 Jan 2002 02:03:33 -0500
Received: from dsl-213-023-043-248.arcor-ip.net ([213.23.43.248]:8978 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288512AbSADHDS>;
	Fri, 4 Jan 2002 02:03:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Ion Badulescu <ion@cs.columbia.edu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Fri, 4 Jan 2002 08:05:56 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200201031605.g03G57e22947@guppy.limebrokerage.com> <20020103150705.F25846@conectiva.com.br> <20020103123623.X12868@lynx.no>
In-Reply-To: <20020103123623.X12868@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MOQT-0001Az-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 3, 2002 08:36 pm, Andreas Dilger wrote:
> I removed the following two options:
> -bs: Put a space between sizeof and its argument.
> -psl: Put the type of a procedure on the line before its name.
> 
> I added the following options:
> -nbbo: don't prefer to break lines before boolean operators
> -ci8: indent continuation lines 8 characters
> -ncs: Do not put a space after cast operators.

Not putting a space after a cast is gross ;)

> -lps: Leave space between # and preprocessor directive.
> -pmt: Preserve access and modification times on output files.
> -npro: Do not read .indent.pro files.

--
Daniel
