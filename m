Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288047AbSAQB00>; Wed, 16 Jan 2002 20:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSAQB0W>; Wed, 16 Jan 2002 20:26:22 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:44782 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288047AbSAQB0L>; Wed, 16 Jan 2002 20:26:11 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020116164758.F12306@thyrsus.com> 
In-Reply-To: <20020116164758.F12306@thyrsus.com>  <esr@thyrsus.com> <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de> 
To: esr@thyrsus.com
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 01:26:02 +0000
Message-ID: <26592.1011230762@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> If you stick to the CML1-equivalent facilities, you'll get almost
> CML1-equivalent behavior.  It's "almost" partly because the hardware
> symbols have more platform- and bus-type guards than they used to --
> but mostly because I have not emulated the numerous CML1 bugs. 

I'm concerned by the 'platform- and bus-type guards' to which you refer. 
Could you give some examples where the behaviour has changed? Lots of 
embedded non-x86, non-ISA boxen have ISA network chips glued in somehow, 
for example. I hope you haven't helpfully stopped that from working.

--
dwmw2


