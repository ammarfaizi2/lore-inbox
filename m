Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752051AbWJWWe3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbWJWWe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWJWWe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:34:29 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:61188 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1752051AbWJWWe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:34:27 -0400
Date: Tue, 24 Oct 2006 08:33:58 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, Zhu Yi <yi.zhu@intel.com>,
       LKML <linux-kernel@vger.kernel.org>, jketreno@linux.intel.com
Subject: Re: 2.6.19-rc2: ieee80211/ipw2200 regression
Message-ID: <20061023223357.GA7461@gondor.apana.org.au>
References: <200610230244.43948.s0348365@sms.ed.ac.uk> <453CE3A4.7030003@trash.net> <200610231653.48797.s0348365@sms.ed.ac.uk> <200610231703.17557.s0348365@sms.ed.ac.uk> <453CE924.4030604@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453CE924.4030604@trash.net>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 06:09:08PM +0200, Patrick McHardy wrote:
> 
> I've added CONFIG_ECB to the ones you mentioned and CONFIG_CBC to
> gssapi.
> 
> Signed-off-by: Patrick McHardy <kaber@trash.net>

Thanks a lot Patrick! I'll put this into crypto-2.6.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
