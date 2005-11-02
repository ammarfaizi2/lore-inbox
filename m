Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbVKBRmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbVKBRmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 12:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVKBRmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 12:42:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:21401 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751266AbVKBRml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 12:42:41 -0500
In-Reply-To: <20051102092959.GA15515@alpha.home.local>
To: Willy Tarreau <willy@w.ods.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>, netdev@vger.kernel.org,
       Yan Zheng <yzcorp@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]IPv6: small fix for ip6_mc_msfilter(...)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF9D4BE592.A4BBC034-ON882570AD.00608386-882570AD.006143BA@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 2 Nov 2005 09:42:37 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 11/02/2005 10:42:45,
	Serialize complete at 11/02/2005 10:42:45
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote on 11/02/2005 01:29:59 AM:
 
> Marcelo, David, does this backport seem appropriate for 2.4.32 ? I 
verified
> that it compiles, nothing more.

        Yes.

> If it's OK, I've noticed another patch that
> Yan posted today and which might be of interest before a very solid 
release.

        I think they should be reviewed first. :-)

                                                +-DLS

