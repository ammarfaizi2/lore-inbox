Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263552AbTCUHof>; Fri, 21 Mar 2003 02:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263553AbTCUHof>; Fri, 21 Mar 2003 02:44:35 -0500
Received: from [66.70.28.20] ([66.70.28.20]:45071 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S263552AbTCUHoe>; Fri, 21 Mar 2003 02:44:34 -0500
Date: Wed, 19 Mar 2003 23:44:42 +0100
From: DervishD <raul@pleyades.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mirrors <mirrors@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030319224442.GA9208@DervishD>
References: <3E78D0DE.307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E78D0DE.307@zytor.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi HPA :)

 H. Peter Anvin dixit:
> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.

    Just one point: while with kernel sources the space saving is
notable using .bz2 instead of .gz, in my experience with different
files, formats, etc... the saving is negligible and the speed just
sucks, gzip beats bzip2 for me in general.

    Anyway I think bzip2 is standard nowadays.

> i) Does this sound reasonable to everyone?  In particular, is there any
> loss in losing the "original" compressed files?

    IMHO, just the decompression speed. I've made no tests, but if
the kernel sources behave like other archives I have, .gz is faster.
OTOH, you save a few megs for downloading, and this is *very*
important too.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://www.pleyades.net/~raulnac
