Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136016AbRDVKOL>; Sun, 22 Apr 2001 06:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136015AbRDVKOC>; Sun, 22 Apr 2001 06:14:02 -0400
Received: from duba03h03-0.dplanet.ch ([212.35.36.23]:25348 "EHLO
	duba03h03-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S136016AbRDVKNs>; Sun, 22 Apr 2001 06:13:48 -0400
Message-ID: <3AE2B853.396A3040@dplanet.ch>
Date: Sun, 22 Apr 2001 12:54:11 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
CC: esr@thyrsus.com, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
In-Reply-To: <200104220251.f3M2pOeJ023588@sleipnir.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> "Giacomo A. Catenazzi" <cate@dplanet.ch> said:
> 
> [...]
> 
> > It whould nice also if we include the type of the license (GPL,...).
> 
> If it's in-kernel, it is GPLed.

No if it is build into the kernel is GPL or GPL compatible.
some PPP drivers can be built only as modules because of
the linking restriction of GPL code to non GPL compatible
code.
In kernel there are also some automatic generated file.
GPL requires sources!

But this is off-topic for the main lkml.

	giacomo
