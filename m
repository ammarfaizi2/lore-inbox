Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbVCBVe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbVCBVe3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVCBVdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:33:40 -0500
Received: from isilmar.linta.de ([213.239.214.66]:20951 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262506AbVCBVay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:30:54 -0500
Date: Wed, 2 Mar 2005 22:30:52 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Re: 2.6.11-rc5-mm1
Message-ID: <20050302213052.GA11285@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Alexander Gran <alex@zodiac.dnsalias.org>,
	Andrew Morton <akpm@osdl.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20050301024804.09eadb6e.akpm@osdl.org> <200503011157.03764@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200503011157.03764@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 11:57:03AM +0100, Alexander Gran wrote:
> Am Dienstag, 1. März 2005 11:48 schrieb Andrew Morton:
> > Alex, please use mailing lists...
> 
> sorry, I was used to have reply-to set to the mailing list ;) 
> double-checking next time..
> 
> > Dominik, do we really always want to drag in the firmware loader if
> > CONFIG_PCMCIA?
> 
> Hmm. I've enabled the firmware loader that fixes at least the compile error...
> Now rebooting. More info after my system programming exam in 1 hour..... ;)

Updated patch submitted -- see

http://lists.infradead.org/pipermail/linux-pcmcia/2005-March/001580.html

	Dominik
