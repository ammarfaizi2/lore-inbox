Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUHTTeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUHTTeK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 15:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUHTTbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 15:31:35 -0400
Received: from herkules.viasys.com ([194.100.28.129]:14525 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S268662AbUHTTaf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 15:30:35 -0400
Date: Fri, 20 Aug 2004 22:30:24 +0300
From: Ville Herva <vherva@viasys.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, petr@vandrovec.name,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040820193024.GL23741@viasys.com>
Reply-To: vherva@viasys.com
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org> <20040820184932.GA11789@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040820184932.GA11789@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 08:49:33PM +0200, you [Arjan van de Ven] wrote:
> > > 
> > >  Ok, 2.6.8.1-mm2 minus dev-mem-restriction-patch.patch fixes the "cannot
> > >  allocate memory" problem. 
> > 
> > Thanks for working that out.
> > 
> > Strange.  I'd have assumed that the Fedora kernels include that patch.
> 
> we do. Maybe you have an older (rare) vmware version ???

Yes, VMwareWorkstation-3.2.0-2230. 

Looks like I'll need to break my piggy bank and consider upgrading.
Commercial software... ;@)


-- v -- 

v@iki.fi

