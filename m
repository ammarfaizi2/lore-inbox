Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVEDVR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVEDVR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVEDVR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:17:27 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:8117 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261596AbVEDVRY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:17:24 -0400
X-QSS-TOXIC-Mail-From: solt2@dns.toxicfilms.tv via dns
X-QSS-TOXIC: 1.25st (Clear:RC:1(213.238.100.215):. Processed in 0.045188 secs Process 28856)
Date: Wed, 4 May 2005 23:17:22 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1104082357.20050504231722@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: ata over ethernet question
In-Reply-To: <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Wednesday, May 4, 2005, 9:48:36 PM, you wrote:
> That seems to be the basic idea but there doesn't seem to be a provider
> stack just yet, just a 'client' (though I could be wrong).  AOE is
> similar in concept to iSCSI with the biggest difference being that AOE
> runs over Ethernet and is thus non-routeable.  iSCSI operates over IP so
> you can do all kinds of fun IP games with it.
Thanks, this is interesting. Does the iSCSI implementation out there have
this provider stack ?

Regards,
Maciej


