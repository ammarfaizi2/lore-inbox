Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270165AbTGMICR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 04:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270167AbTGMICQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 04:02:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32699
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270165AbTGMICK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 04:02:10 -0400
Subject: Re: [PATCH] AMD760MPX: bogus chispset ? (was PROBLEM: sound
	is	stutter, sizzle with lasts kernel releases)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xi <xizard@enib.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0F97DC.5090500@enib.fr>
References: <3F0EED9B.4080502@enib.fr>
	 <1057943291.20629.30.camel@dhcp22.swansea.linux.org.uk>
	 <3F0F2667.7090103@enib.fr>
	 <1057959456.20637.45.camel@dhcp22.swansea.linux.org.uk>
	 <3F0F97DC.5090500@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058083995.31918.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Jul 2003 09:13:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-07-12 at 06:08, xi wrote:
> * patch_AMD762_PCI_compliance_set_by_bios.diff : lets the BIOS decide 
> about PCI configuration

Breaks i2o with a 1004 BIOS on the ASUS dual athlon setup
> 
> * patch_AMD762_PCI_default_AMD_settings.diff : follow AMD 
> recommendations but not PCI specs.

Looks better


