Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWCQLAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWCQLAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 06:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbWCQLAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 06:00:23 -0500
Received: from main.gmane.org ([80.91.229.2]:50071 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751397AbWCQLAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 06:00:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Fri, 17 Mar 2006 12:38:33 +0200
Message-ID: <dve3j9$r50$1@sea.gmane.org>
References: <20060305192709.GA3789@skyscraper.unix9.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.86.125.193
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bjd wrote:

> From: Bauke Jan Douma <bjdouma@xs4all.nl>
> 
> On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
> and MC97 modem controller are deactivated when a second PCI soundcard
> is present.  This patch enables them.


Thanks for the patch! I can't wait to go home and try it. AFAIK it affects
other boards aside of the ASUS A8V using the same chipset. Once I contacted
the ASUS support and they told me due to the chipset's design it is not
possible to enable the onboard sound when a PCI card is installed. It is
amazing that you could do it. :-)

Andras

