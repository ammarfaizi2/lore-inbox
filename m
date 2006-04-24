Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWDXO2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWDXO2c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWDXO2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:28:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:31405 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750749AbWDXO2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:28:31 -0400
Date: Mon, 24 Apr 2006 09:28:29 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424142829.GB25368@sergelap.austin.ibm.com>
References: <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424125641.GD9311@sergelap.austin.ibm.com> <1145887333.29648.44.camel@localhost.localdomain> <20060424140407.GD22703@sergelap.austin.ibm.com> <1145889094.29648.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145889094.29648.59.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> On Llu, 2006-04-24 at 09:04 -0500, Serge E. Hallyn wrote:
> > Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> > > Thus this sort of stuff needs to be taken seriously. Can SuSE provide a
> > > good reliable policy for AppArmour to people, can Red Hat do the same
> > > with SELinux ?
> > 
> > That's a little more than half the question.  The other 40% is can users
> > write good policies.
> 
> Normal users don't write file system allocation policies, they don't
> configure the safety systems for their car and they don't generally
> configure most other similar policies.

s/users/everyday admin/  ?

Perhaps in the end a massive amount of education is the only answer.
But in any case only good can come of such a contest.

-serge
