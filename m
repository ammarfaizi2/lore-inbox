Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262494AbVCPEIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbVCPEIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 23:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVCPEIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 23:08:44 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:63465
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262494AbVCPEIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 23:08:43 -0500
Date: Tue, 15 Mar 2005 20:06:51 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: Can no longer build ipv6 built-in (2.6.11, today's BK head)
Message-Id: <20050315200651.6c0eb372.davem@davemloft.net>
In-Reply-To: <200503160353.j2G3rTKr015647@mail02.syd.optusnet.com.au>
References: <200503160353.j2G3rTKr015647@mail02.syd.optusnet.com.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 14:53:29 +1100
Peter Chubb <peterc@gelato.unsw.edu.au> wrote:

> A simple fix is to delete the __exit from the various functions now that
> they're called other than at module_exit.
> 
> Signed-off-by: Peter Chubb <peterc@gelato.unsw.edu.au>

Applied, thanks Peter.
