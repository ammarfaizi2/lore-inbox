Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVEWVWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVEWVWJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 17:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEWVWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 17:22:09 -0400
Received: from ns2.suse.de ([195.135.220.15]:53673 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261985AbVEWVWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 17:22:04 -0400
Date: Mon, 23 May 2005 23:21:57 +0200
From: Karsten Keil <kkeil@suse.de>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, jgarzik@pobox.com
Subject: Re: [PATCH] bug in VIA PCI IRQ routing
Message-ID: <20050523212157.GA18624@pingi3.kke.suse.de>
Mail-Followup-To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
	Ondrej Zary <linux@rainbow-software.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jgarzik@pobox.com
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B4902@scl-exch2k3.phoenix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C31B4902@scl-exch2k3.phoenix.com>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks to Ondrej for the datasheet snippet.

On Mon, May 23, 2005 at 12:53:41PM -0700, Aleksey Gorelov wrote:
...
> 
> Hmm, this is way different.
> 
> Karsten, 
> 
>   could you please verify if attached patch works for you ?

Will do so, since the systems are not under my control, it may take some
time.
Thanks for the patch.

>   Another unknown C596 south bridge. I wonder if it the same as 586, or
> closer to 686 ?

It is a 82C586B south bridge (printed on the chip).

-- 
Karsten Keil
SuSE Labs
ISDN development
