Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264813AbTGKTdp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264825AbTGKS5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:57:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36280
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264982AbTGKSPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:15:22 -0400
Subject: RE: Geode GX1, video acceleration -> crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keyser Soze <keyser_soze2u@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ferenc@engard.hu
In-Reply-To: <20030711181025.14633.qmail@web10001.mail.yahoo.com>
References: <20030711181025.14633.qmail@web10001.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057948046.20636.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 19:27:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 19:10, Keyser Soze wrote:
> Try turning off ide dma and see if that helps.  You
> will lose very little by turning off udma on this
> system and I'll bet you end up being more stable.

You'll lose a lot of disk performance turning off UDMA on a Geode GX1,
down from full UDMA33 to about 1Mbyte/second. It should be rock solid
at least my Geode's are. Slow... but solid

