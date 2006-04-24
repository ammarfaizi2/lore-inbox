Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWDXMcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWDXMcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWDXMcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:32:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20384 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750742AbWDXMci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:32:38 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060424082424.GH440@marowsky-bree.de>
References: <1145309184.14497.1.camel@localhost.localdomain>
	 <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
	 <4445484F.1050006@novell.com>
	 <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
	 <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 13:42:31 +0100
Message-Id: <1145882551.29648.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 10:24 +0200, Lars Marowsky-Bree wrote:
> On 2006-04-23T05:45:34, Valdis.Kletnieks@vt.edu wrote:
> 
> > > AppArmor are not likely to put careful thought into the policies that
> > > they use?
> > They're not likely to put careful thought into it, *AND* that saying things
> > like "AppArmor is so *simple* to configure" only makes things worse - this
> > encourages unqualified people to create broken policy configurations.
> 
> That is about the dumbest argument I've heard so far, sorry. 

Its the conclusion of most security experts I know that broken security
is worse than no security at all. 

