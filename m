Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVDHIAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVDHIAZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVDHH6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 03:58:38 -0400
Received: from smtp2.wanadoo.fr ([193.252.22.29]:52821 "EHLO smtp2.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262739AbVDHHvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:51:46 -0400
X-ME-UUID: 20050408075145815.C70191C00236@mwinf0209.wanadoo.fr
Date: Fri, 8 Apr 2005 09:47:40 +0200
To: Chris Friesen <cfriesen@nortel.com>
Cc: Josselin Mouette <joss@debian.org>, linux-os@analogic.com,
       debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408074740.GC9057@pegasos>
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br> <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet> <4252DDE6.5040500@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4252DDE6.5040500@nortel.com>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 12:50:14PM -0600, Chris Friesen wrote:
> Josselin Mouette wrote:
> 
> >The fact is also that mixing them with a GPLed software gives
> >an result you can't redistribute - although it seems many people
> >disagree with that assertion now.
> 
> This is only true if the result is considered a "derivative work" of the 
> gpl'd code.
> 
> The GPL states "In addition, mere aggregation of another work not based 
> on the Program with the Program (or with a work based on the Program) on 
> a volume of a storage or distribution medium does not bring the other 
> work under the scope of this License."
> 
> Since the main cpu does not actually run the binary firmware, the fact 
> that it lives in main memory with the code that the cpu *does* run is 
> irrelevent.  In this case, the Debian stance is that the kernel proper 
> and the binary firmware are "merely aggregated" in a volume of storage ( 
> ie. system memory).

The problem is that you can only argue it is mere agregation, if the copyright
notice doesn't de-facto put said firmware blobs under the GPL, thus making
them undistributable by the selfsame definition of the GPL.

Friendly,

Sven Luther

