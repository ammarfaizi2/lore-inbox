Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293341AbSB1OMi>; Thu, 28 Feb 2002 09:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293400AbSB1OKM>; Thu, 28 Feb 2002 09:10:12 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:11443 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S293348AbSB1OIw>;
	Thu, 28 Feb 2002 09:08:52 -0500
Date: Thu, 28 Feb 2002 15:08:39 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Henrique Gobbi <henrique@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic HDLC Protocols
Message-ID: <20020228150839.A6847@fafner.intra.cogenit.fr>
In-Reply-To: <02022809445800.00921@henrique.cyclades.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <02022809445800.00921@henrique.cyclades.com.br>; from henrique@cyclades.com on Thu, Feb 28, 2002 at 09:44:58AM -0300
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrique Gobbi <henrique@cyclades.com> :
[...]
> I'd like to know what RFC's the protocols provided by Generic HDLC (PPP, 
> Frame-Relay ansy & CCITT, CISCO and X.25) support.
> I look up in the source code but this information is not there (should it 
> be?).

Which code specifically:
- 2.4.x ?
- ftp://ftp.pm.waw.pl/pub/Linux/hdlc/experimental/hdlc-2.5.3.patch.gz ?
(see last weeks discussions on l-k for this one)

> Can someone give me this information ?

Maintener (khc@pm.waw.pl) will return from holidays in 3 weeks.
Afaicr it's rfc1490 style for FR. Krzysztof's last framework is interesting
if you want to adress missing areas. 

-- 
Ueimor
