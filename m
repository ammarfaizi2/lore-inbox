Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbVI2XCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbVI2XCv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVI2XCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:02:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:60357 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751335AbVI2XCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:02:50 -0400
Subject: Re: RocketPoint 1520 [hpt366] fails clock stabilization
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Loren M. Lang" <lorenl@alzatex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050929103309.GA12361@alzatex.com>
References: <20050929103309.GA12361@alzatex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Sep 2005 00:30:11 +0100
Message-Id: <1128036611.9290.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-09-29 at 03:33 -0700, Loren M. Lang wrote:
> Please CC me as I'm not on the list.
> 
> I just purchased a HighPoint Rocket 1520 SATA controller.  There seems
> to be no libata driver (yet), but there is an ide driver, hpt366.  When

Is this 302 or 302N based (what does lspci -vxx say about it ?)



