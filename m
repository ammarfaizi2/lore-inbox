Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUKWWsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUKWWsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbUKWWqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:46:51 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:58498
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261570AbUKWWlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:41:50 -0500
Date: Tue, 23 Nov 2004 17:53:24 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "O. Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org
Subject: Re: ISO9660 file size limitation
Message-ID: <20041123225324.GA4447@animx.eu.org>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"O. Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org
References: <20041118083638.CVFG2440.fep02.ttnet.net.tr@localhost> <20041118221052.GA26378@animx.eu.org> <20041123114204.GD4524@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123114204.GD4524@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Thu, Nov 18, 2004 at 05:10:53PM -0500, Wakko Warner wrote:
> > > 2.6 took a better route making cruft a mount time option.
> > > I use the attached patch against 2.4.28, ported from the
> > > patches by Andries Brouwer posted at:
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=103420043728469&w=2
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=108808967926140&w=2
> > > 
> > > Why do I have a feeling that Marcelo would reject this :/
> > 
> > Hmm, dunno.  The diffs in the email definately took care of this as well.
> 
> Looks necessary and well tested, has just been applied to v2.4 tree.

That's cool, so this will be 2.4.29?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
