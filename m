Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289017AbSBJACF>; Sat, 9 Feb 2002 19:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289018AbSBJAB5>; Sat, 9 Feb 2002 19:01:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57604 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289017AbSBJABo>;
	Sat, 9 Feb 2002 19:01:44 -0500
Message-ID: <3C65B865.D79E080E@mandrakesoft.com>
Date: Sat, 09 Feb 2002 19:01:41 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paule@ilu.vu
CC: linux-kernel@vger.kernel.org
Subject: Re: 3com pcmcia modules.
In-Reply-To: <20020209151533.A644@ilu.vu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paule@ilu.vu wrote:
> Apologies if this has been brought up before,
> but whatever happened to the 3c575 (3com pcmcia) card
> driver/module in 2.5.x branch? (it was in 2.2.19 for sure).

It's not needed.  "3c59x" provided full support for PCI and CardBus.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
