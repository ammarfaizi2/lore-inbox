Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318293AbSGXXSQ>; Wed, 24 Jul 2002 19:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318294AbSGXXSQ>; Wed, 24 Jul 2002 19:18:16 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.146]:19699 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S318293AbSGXXSP>; Wed, 24 Jul 2002 19:18:15 -0400
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Wed, 24 Jul 2002 16:22:23 -0700
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: gibbs@scsiguy.com
Subject: Re: [PATCH] aic7xxx driver doesn't release region
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Message-Id: <20020724161518.280B.T-KOUCHI@mvf.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002 16:28:48 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> >Hi,
> >
> >This is a patch to fix releasing memory and io regions for the
> >aic7xxx driver.  This applies both 2.4- and 2.5-series.
> 
> I don't recall when exactly this was fixed in the aic7xxx driver,
> but probably 6.2.5 or so.  The 2.5.X kernel must not be using
> a recent version of the driver.  Marcelo's tree has 6.2.8
> which definitely does not require this patch (won't even apply).

Oops, I should have to check the latest 2.4.19-rc series first.
I assumed that 2.5.x contains the latest.
Sorry for bothering you and thanks.

Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

