Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUIWVsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUIWVsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUIWVsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:48:38 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:11691 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S267449AbUIWVrd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:47:33 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andre Eisenbach <int2str@gmail.com>
Subject: Re: 2.6.9-rc2-mm2 ohci_hcd doesn't work
Date: Thu, 23 Sep 2004 15:47:21 -0600
User-Agent: KMail/1.7
Cc: Roman Weissgaerber <weissg@vienna.at>,
       linux-usb-devel@lists.sourceforge.net,
       David Brownell <dbrownell@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200409231457.16979.bjorn.helgaas@hp.com> <7f800d9f040923142648104784@mail.gmail.com>
In-Reply-To: <7f800d9f040923142648104784@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231547.21875.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 September 2004 3:26 pm, Andre Eisenbach wrote:
> Does the DL360 have a BIOS option to allow "legacy usb devices"?
> My notebook does, and if set to yes, it fails with that error with or
> without pci=routeirq.

No such DL360 option that I can find.  Any idea what
"allow legacy usb devices" means?
