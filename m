Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264067AbRFMQbT>; Wed, 13 Jun 2001 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264076AbRFMQbJ>; Wed, 13 Jun 2001 12:31:09 -0400
Received: from [216.101.162.242] ([216.101.162.242]:17831 "EHLO
	pizda.ninka.net") by vger.kernel.org with ESMTP id <S264067AbRFMQbF>;
	Wed, 13 Jun 2001 12:31:05 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.37875.301864.200340@pizda.ninka.net>
Date: Wed, 13 Jun 2001 09:25:23 -0700 (PDT)
To: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>
Cc: linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-06 inet[6]_create() register/unregister table
In-Reply-To: <15141.3072.343642.887311@theor.em.cig.mot.com>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
	<15141.3072.343642.887311@theor.em.cig.mot.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


La Monte H.P. Yarroll writes:
 > Here is the register/unregister inet[6]_create() table patch revised
 > to disable deregistration and overriding of TCP and UDP.

I've applied your patches, thank you.

Please enable real tabs in your editor next time though :-)

Later,
David S. Miller
davem@redhat.com
