Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267197AbUHVN7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267197AbUHVN7e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 09:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUHVN7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 09:59:34 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:59272 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267197AbUHVN7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 09:59:33 -0400
Date: Sun, 22 Aug 2004 15:59:23 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Ville Herva <vherva@viasys.com>, Arjan van de Ven <arjanv@redhat.com>,
       Andrew Morton <akpm@osdl.org>, petr@vandrovec.name,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2 breaks vmware
Message-ID: <20040822135923.GA24092@vana.vc.cvut.cz>
References: <20040820104230.GH23741@viasys.com> <20040820035142.3bcdb1cb.akpm@osdl.org> <20040820131825.GI23741@viasys.com> <20040820144304.GF8307@viasys.com> <20040820151621.GJ23741@viasys.com> <20040820114518.49a65b69.akpm@osdl.org> <20040820184932.GA11789@devserv.devel.redhat.com> <20040820193024.GL23741@viasys.com> <20040822114214.GB19768@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040822114214.GB19768@thundrix.ch>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 01:42:14PM +0200, Tonnerre wrote:
> Salut,
> 
> On Fri, Aug 20, 2004 at 10:30:24PM +0300, Ville Herva wrote:
> > Yes, VMwareWorkstation-3.2.0-2230. 
> > 
> > Looks like I'll need to break my piggy bank and consider upgrading.
> > Commercial software... ;@)
> 
> Does VMware > 4.0 still require cmov?

Yes, this requirement is not going to go away: VMware >= 4.0 / GSX >= 3.0 require
processors which support CMOV instruction.
							Petr


