Return-Path: <linux-kernel-owner+w=401wt.eu-S1753422AbWLOUdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbWLOUdM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbWLOUdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:33:12 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60821 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753414AbWLOUdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:33:11 -0500
X-Greylist: delayed 951 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 15:33:10 EST
Date: Fri, 15 Dec 2006 21:15:22 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061215201522.GA11288@electric-eye.fr.zoreil.com>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215132740.GD11579@xi.wantstofly.org>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek <buytenh@wantstofly.org> :
[...]
> Is there a way we can have this done by default on the n2100?  I guess
> that since it's a PCI device, there isn't much hope for that..?

Do you mean an automagically tuned default value based on CONFIG_ARM ?

-- 
Ueimor
