Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVCICFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVCICFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 21:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVCICCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 21:02:15 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:38309 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262300AbVCIBvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 20:51:00 -0500
Date: Wed, 9 Mar 2005 02:50:55 +0100
From: Karsten Keil <kkeil@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Christophe Lucas <c.lucas@ifrance.com>,
       Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2
Message-ID: <20050309015055.GA30498@pingi3.kke.suse.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>,
	Christophe Lucas <c.lucas@ifrance.com>,
	Domen Puncer <domen@coderock.org>, linux-kernel@vger.kernel.org
References: <20050308033846.0c4f8245.akpm@osdl.org> <20050309002046.GD3146@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309002046.GD3146@stusta.de>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.8-24.10-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 01:20:46AM +0100, Adrian Bunk wrote:
> On Tue, Mar 08, 2005 at 03:38:46AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.11-mm1:
> >...
> > +drivers-isdn-tpam-convert-to-pci_register_driver.patch
> >...
> >  Little code tweaks.
> >...
> 
> Please drop this patch.
> 
> Karsten has a patch ready to remove this driver (because the hardware it 
> was supposed to drive never went into production), and such patches only 
> cause needless rediffs.
> 
> @Karsten:
> Could you submit your patch to remove tpam to Andrew?
> 

:-) already done few houres ago (against -mm2)


-- 
Karsten Keil
SuSE Labs
ISDN development
