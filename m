Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292253AbSBBJPM>; Sat, 2 Feb 2002 04:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292255AbSBBJOu>; Sat, 2 Feb 2002 04:14:50 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:43509 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S292253AbSBBJOk>; Sat, 2 Feb 2002 04:14:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <26967.1012640368@ocs3.intra.ocs.com.au> 
In-Reply-To: <26967.1012640368@ocs3.intra.ocs.com.au> 
To: Keith Owens <kaos@ocs.com.au>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Feb 2002 09:14:28 +0000
Message-ID: <23962.1012641268@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kaos@ocs.com.au said:
>  Does anything still use this symbol or is it dead?  Quite valid
> question. 

Indeed. 

>  The script is NOT an automatic list of what can be cleaned up.  I
> doubt that such a list can be generated in the face of the kernel
> config system and third party modules.  It is only a starting point
> for symbols that need reviewing.

OK, cool. As it came out of the discussion about -ffunction-sections and
automatically garbage-collecting unused functions during the build, I
thought you had other, less sane intentions. Sorry for the misunderstanding.

--
dwmw2


