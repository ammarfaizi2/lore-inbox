Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWDEPmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWDEPmW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWDEPmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:42:22 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:492 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751100AbWDEPmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:42:21 -0400
Subject: Re: [PATCH] [IPSEC] Avoid null pointer dereference in
	xfrm4_rcv_encap
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1144249178.10340.5.camel@kleikamp.austin.ibm.com>
References: <1144249178.10340.5.camel@kleikamp.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 10:41:57 -0500
Message-Id: <1144251717.10336.18.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Never mind.  Somehow I missed Herbert's patch for this in the netdev
archives.
-- 
David Kleikamp
IBM Linux Technology Center

