Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWF0Ome@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWF0Ome (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWF0Ome
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:42:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13186 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030193AbWF0Omd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:42:33 -0400
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on
	i386
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
References: <20060626151012.GR23314@stusta.de>
	 <20060626153834.GA18599@redhat.com>
	 <1151336815.3185.61.camel@laptopd505.fenrus.org>
	 <20060626155439.GB18599@redhat.com>
	 <Pine.LNX.4.61.0606271626470.10810@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 16:42:22 +0200
Message-Id: <1151419342.5217.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-27 at 16:27 +0200, Jan Engelhardt wrote:
> > > cli/sti should just be removed, or at least have those drivers marked
> > > BROKEN... nobody is apparently using them anyway...
> >
> >Just ISDN really.
> >
> And ISDN is widespread in Germany (besides 56k and DSL(PPPOE)).
> 

so it really should be fixed ;-)


