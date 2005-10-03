Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbVJCSpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbVJCSpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932598AbVJCSpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:45:34 -0400
Received: from [81.2.110.250] ([81.2.110.250]:21989 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932594AbVJCSpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:45:33 -0400
Subject: Re: what's next for the linux kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200510030255.j932toIK012248@turing-police.cc.vt.edu>
References: <20051002204703.GG6290@lkcl.net>
	 <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com>
	 <20051002230545.GI6290@lkcl.net>
	 <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net>
	 <20051003005400.GM6290@lkcl.net>
	 <200510030255.j932toIK012248@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 20:13:06 +0100
Message-Id: <1128366786.26992.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-10-02 at 22:55 -0400, Valdis.Kletnieks@vt.edu wrote:
> The HP2114 and DEC KL10/20 were able to dereference a chain of indirect bits
> back in the 70's (complete with warnings that hardware wedges could occur if
> an indirect reference formed a loop or pointed at itself). 

The KL10 has an 8 way limit. The PDP-6 didn't but then it also lacked an
MMU.


