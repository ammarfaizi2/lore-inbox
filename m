Return-Path: <linux-kernel-owner+w=401wt.eu-S1751637AbXAPUyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXAPUyn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXAPUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:54:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35146 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbXAPUyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:54:43 -0500
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, trivial@kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20070116185414.GC718@Ahmed>
References: <20070116080136.GA30133@Ahmed>
	 <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
	 <20070116185414.GC718@Ahmed>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 16 Jan 2007 18:54:23 -0200
Message-Id: <1168980863.12069.1.camel@areia>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2007-01-16 às 20:54 +0200, Ahmed S. Darwish escreveu:
> On Tue, Jan 16, 2007 at 03:36:16AM -0500, Robert P. J. Day wrote:
> > On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:
> > 
> > > Use ARRAY_SIZE macro in pvrusb2-hdw.c file
> > >
> > > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> > 
> > ... snip ...
> > 
> > i'm not sure it's worth submitting multiple patches to convert code
> > expressions to the ARRAY_SIZE() macro since i was going to wait for
> > the next kernel release, and do that in one fell swoop with a single
> > patch.
> 
> No problem :). But will a single patch be accepted ?. Grepping the tree,I found
> many results that will make the patch very very big. 
> Should I stop sending them till 2.6.20 ?. 
> If so, I've made any way about 10 patches dealing with different subsytems. 
> I can send them to you to avoid this little work duplication.

The folded patch doesn't seem to be big. I'll apply it at development
tree to be sent to 2.6.21. There's no hurry of such patch for 2.6.20.
> 
> 
> Regards

