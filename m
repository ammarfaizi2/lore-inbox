Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269124AbTCBLLu>; Sun, 2 Mar 2003 06:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269139AbTCBLLu>; Sun, 2 Mar 2003 06:11:50 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:42409 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S269124AbTCBLLu>; Sun, 2 Mar 2003 06:11:50 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: Dan Kegel <dank@kegel.com>, Matthias Schniedermeyer <ms@citd.de>,
       Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
In-Reply-To: <1046578585.2544.451.camel@spc1.mesatop.com>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
	 <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com>
	 <3E6167B1.6040206@kegel.com>  <3E617428.3090207@kegel.com>
	 <1046578585.2544.451.camel@spc1.mesatop.com>
Organization: 
Message-Id: <1046604117.12947.16.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 02 Mar 2003 11:21:58 +0000
Subject: Re: [PATCH] kernel source spellchecker
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-02 at 04:16, Steven Cole wrote:

> Another correction to the corrections file:
> 
> Licensed=Licenced
>          ^^^^^^^^
> I think Licenced is OK in the UK.
> See http://www.gsu.edu/~wwwesl/egw/jones/differences.htm

'Licenced' is not OK in the UK; it should be corrected to 'Licensed'.

In the UK, 'licence' is a noun, 'license' is a verb -- just as with
practice/practise and advice/advise etc. in both variants of the
language.

I think we also want to add:

Decompressing=Uncompressing

You should also refrain from 'correcting' the already-correct British
spellings of 'modelled'.

It might also be worth adding a list of 'suspect' spellings -- which
require human intervention. Such items might include 'indices=indexes'
and 'erratum=errata' although you can't do it automatically because
sometimes the right-hand side is actually correct.

-- 
dwmw2

