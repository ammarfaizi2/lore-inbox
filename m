Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVDFAOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVDFAOm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 20:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVDFAOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 20:14:42 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:24762 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262025AbVDFAOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 20:14:23 -0400
X-ME-UUID: 20050406001421734.B33671C01625@mwinf0507.wanadoo.fr
Date: Wed, 6 Apr 2005 02:10:52 +0200
To: Josselin Mouette <joss@debian.org>
Cc: Chris Friesen <cfriesen@nortel.com>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050406001052.GA3208@pegasos>
References: <lLj-vC.A.92G.w4pUCB@murphy> <4252A821.9030506@almg.gov.br> <Pine.LNX.4.61.0504051123100.16479@chaos.analogic.com> <1112723637.4878.14.camel@mirchusko.localnet> <4252DDE6.5040500@nortel.com> <1112727369.4878.25.camel@mirchusko.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1112727369.4878.25.camel@mirchusko.localnet>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 08:56:09PM +0200, Josselin Mouette wrote:
> Le mardi 05 avril 2005 à 12:50 -0600, Chris Friesen a écrit :
> > Josselin Mouette wrote:
> > 
> > > The fact is also that mixing them with a GPLed software gives
> > > an result you can't redistribute - although it seems many people
> > > disagree with that assertion now.
> > 
> > This is only true if the result is considered a "derivative work" of the 
> > gpl'd code.
> > 
> > The GPL states "In addition, mere aggregation of another work not based 
> > on the Program with the Program (or with a work based on the Program) on 
> > a volume of a storage or distribution medium does not bring the other 
> > work under the scope of this License."
> > 
> > Since the main cpu does not actually run the binary firmware, the fact 
> > that it lives in main memory with the code that the cpu *does* run is 
> > irrelevent.  In this case, the Debian stance is that the kernel proper 
> > and the binary firmware are "merely aggregated" in a volume of storage ( 
> > ie. system memory).
> 
> It merely depends on the definition of "aggregation". I'd say that two
> works that are only aggregated can be easily distinguished and
> separated. This is not the case for a binary kernel module, from which
> you cannot easily extract the firmware and code parts.

Josselin, please read the thread i linked to in debian-legal, and as nobody
really gave reason to oppose it, i believe we have consensus that those
firmware blobs constitute mere agregation, provided they are clearly
identified and properly licenced, which they are not always.

Let's take this to debian-legal only if you want to further discuss it.

Friendly,

Sven Luther

