Return-Path: <linux-kernel-owner+w=401wt.eu-S1751941AbWLOLgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWLOLgp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 06:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWLOLgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 06:36:45 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3687 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751941AbWLOLgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 06:36:44 -0500
X-Greylist: delayed 74921 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 06:36:42 EST
Date: Thu, 14 Dec 2006 14:47:51 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
Cc: Alejandro Riveira =?iso-8859-1?Q?Fern=E1ndez?= 
	<ariveira@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
Message-ID: <20061214144750.GA4022@ucw.cz>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com> <1165406299.3233.436.camel@laptopd505.fenrus.org> <1165407548.5954.224.camel@titan.tbdnetworks.com> <20061206131003.GF24140@stusta.de> <20061209132742.7a25dcb5@localhost.localdomain> <1165679105.7455.116.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165679105.7455.116.camel@titan.tbdnetworks.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So far all first-hand experiences I heard of were positive (i.e. I did
> not get an emaail from anyone saying: It had a negative effect for me),
> so I propose to apply the patch from Con Kolivas. The wording in the
> description still very strongly recommends to not change that value, and
> it's still dependent on EXPERIMENTAL. I append the patch just because

There's a big difference between 'experimental' and 'known to broke
obscure userspace apps'.

-- 
Thanks for all the (sleeping) penguins.
