Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSBGK24>; Thu, 7 Feb 2002 05:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287208AbSBGK2p>; Thu, 7 Feb 2002 05:28:45 -0500
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:29452
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S287204AbSBGK2k>; Thu, 7 Feb 2002 05:28:40 -0500
Date: Thu, 7 Feb 2002 11:28:33 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Michael Cohen <lkml@ohdarn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] 2.4.18-pre8-mjc
Message-ID: <20020207112833.A15829@bouton.inet6-interne.fr>
Mail-Followup-To: Michael Cohen <lkml@ohdarn.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1013073474.3684.3.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1013073474.3684.3.camel@ohdarn.net>; from lkml@ohdarn.net on Thu, Feb 07, 2002 at 04:17:54AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 04:17:54AM -0500, Michael Cohen wrote:
> SiS5513 updates				(?)
Lionel Bouton <Lionel.Bouton@inet6.fr>

Which patch did you take in ?
Post 20020110_1 patches add support to old chipsets (pre-ATA66) but are known to
have buggy chipset detection code.
I've just received a new ECS K7S5AL (old one broken) so I'll be able to test the code myself
again (currently memtest86 testing).
Expect debugged code next week.

Full patch history available at:
http://inet6.dyn.dhs.org/sponsoring/sis5513/index.html

LB.
