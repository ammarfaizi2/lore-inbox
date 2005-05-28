Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbVE1Oh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbVE1Oh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 10:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVE1Oh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 10:37:27 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:58510 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262726AbVE1OhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 10:37:24 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to find if BIOS has already enabled the device
Date: Sat, 28 May 2005 10:37:21 -0400
User-Agent: KMail/1.8
Cc: John Livingston <jujutama@comcast.net>,
       Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <0EF82802ABAA22479BC1CE8E2F60E8C31B5206@scl-exch2k3.phoenix.com> <1117289090.2390.14.camel@localhost.localdomain> <200505281018.18092.kernel-stuff@comcast.net>
In-Reply-To: <200505281018.18092.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281037.21620.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 May 2005 10:18, Parag Warudkar wrote:
> dmesg is perfectly normal, not even timestamp differences before and after
> call to pci_enable_device - since the machine is completely hung for that
> period - not even the clock is ticking?
I should have added - Presence or absence of Nvidia module does not make any 
difference.
-- 
Virtue would go far if vanity did not keep it company.
		-- La Rochefoucauld
