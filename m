Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263980AbUHGSFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbUHGSFN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 14:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUHGSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 14:05:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43916 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263980AbUHGSFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 14:05:07 -0400
Date: Sat, 7 Aug 2004 14:15:00 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races
Message-ID: <20040807171500.GA26084@logos.cnet>
References: <XFMail.20040805104213.pochini@shiny.it> <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 12:30:23PM +0200, Jirka Kosina wrote:
> On Thu, 5 Aug 2004, Giuliano Pochini wrote:
> 
> > I don't remember if this issue has already been discussed here:
> > -----FW: <Pine.LNX.4.44.0408041220550.26961-100000@isec.pl>-----
> > Date: Wed, 4 Aug 2004 12:22:42 +0200 (CEST)
> > From: Paul Starzetz <ihaquer@isec.pl>
> > To: bugtraq@securityfocus.com, vulnwatch@vulnwatch.org,
> >  full-disclosure@lists.netsys.com
> > Subject: Linux kernel file offset pointer races
> 
> It hasn't been discussed here, but at 
> http://linux.bkbits.net:8080/linux-2.4/gnupatch@411064f7uz3rKDb73dEb4vCqbjEIdw 
> you can find a patchset fixing (some of) the mentioned problems. This 
> patchset is from 2.4.27-rc5

"some of" ? 

Do you know any unfixed still broken piece of driver code ? 

