Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVFMTye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVFMTye (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVFMTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:54:24 -0400
Received: from smtp06.auna.com ([62.81.186.16]:62864 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S261275AbVFMTvy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:51:54 -0400
Date: Mon, 13 Jun 2005 19:51:53 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: [RFC] Patch series to remove devfs [00/22]
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
References: <20050611074327.GA27785@kroah.com>
	<1118616273l.18059l.0l@werewolf.able.es> <20050613174355.GB12517@suse.de>
In-Reply-To: <20050613174355.GB12517@suse.de> (from gregkh@suse.de on Mon
	Jun 13 19:43:55 2005)
X-Mailer: Balsa 2.3.3
Message-Id: <1118692313l.5759l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Auth-Info: Auth:LOGIN IP:[83.138.215.85] Login:jamagallon@able.es Fecha:Mon, 13 Jun 2005 21:51:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.13, Greg KH wrote:
> On Sun, Jun 12, 2005 at 10:44:33PM +0000, J.A. Magallon wrote:
> > 
> > On 06.11, Greg KH wrote:
> > > As everyone knows[1], devfs is going to be removed from the kernel soon.
> > > To accomplish this, here is a series of patches (22 in all) that do just
> > > that.  Surprisingly enough, devfs was almost everywhere in the kernel,
> > > that's why it takes so many patches :)
> > > 
> > 
> > You missed this for -mm, do not know if they apply to mainline:
> 
> This patch series was not for -mm, as my comments stated :)
> 

I shifted some offsets and am running it now...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam25 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


