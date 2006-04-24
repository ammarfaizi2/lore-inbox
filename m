Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWDXOVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWDXOVY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWDXOVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:21:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19387 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750784AbWDXOVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:21:23 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424140407.GD22703@sergelap.austin.ibm.com>
References: <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424125641.GD9311@sergelap.austin.ibm.com>
	 <1145887333.29648.44.camel@localhost.localdomain>
	 <20060424140407.GD22703@sergelap.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 15:31:34 +0100
Message-Id: <1145889094.29648.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-24 at 09:04 -0500, Serge E. Hallyn wrote:
> Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> > Thus this sort of stuff needs to be taken seriously. Can SuSE provide a
> > good reliable policy for AppArmour to people, can Red Hat do the same
> > with SELinux ?
> 
> That's a little more than half the question.  The other 40% is can users
> write good policies.

Normal users don't write file system allocation policies, they don't
configure the safety systems for their car and they don't generally
configure most other similar policies.


