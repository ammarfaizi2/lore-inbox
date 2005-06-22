Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVFVJbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVFVJbd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbVFVJ21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:28:27 -0400
Received: from [85.8.12.41] ([85.8.12.41]:32440 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262777AbVFVJWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:22:02 -0400
Message-ID: <42B92D92.7070304@drzeus.cx>
Date: Wed, 22 Jun 2005 11:21:22 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Petrovitsch <bernd@firmix.at>
CC: Roman Zippel <zippel@linux-m68k.org>, kbuild-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Pointer cast warnings in scripts/
References: <42B7F740.6000807@drzeus.cx>	 <Pine.LNX.4.61.0506211413570.3728@scrub.home> <42B80AF9.2060708@drzeus.cx>	 <Pine.LNX.4.61.0506211451040.3728@scrub.home>  <42B80F40.8000609@drzeus.cx> <1119359653.18845.55.camel@tara.firmix.at>
In-Reply-To: <1119359653.18845.55.camel@tara.firmix.at>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch wrote:

>
>The C-standard about "char", "signed char" and "unsigned char"?
>These are 3 different types.
>
>  
>

I was referring to which of the three types is correct for str*().

Rgds
Pierre

