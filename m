Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVBXSYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVBXSYG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVBXSYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:24:06 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:24961 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S262448AbVBXSXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:23:05 -0500
Date: Thu, 24 Feb 2005 19:23:00 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
Message-ID: <20050224182300.GA7778@mail.muni.cz>
References: <20050224175918.GA7627@mail.muni.cz> <20050224181347.GA10847@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050224181347.GA10847@kroah.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 10:13:47AM -0800, Greg KH wrote:
> Is the ehci-hcd driver loaded?  And is your device a high speed one?
> USB 2.0 support does not mean that it actually goes at high speeds, I
> have a USB 2.0 "compliant" low speed USB keyboard here :)

Yes, ehci-hcd driver is loaded. (kernel is 2.6.11-rc3-bk4)

This is the device:
http://www.msi.com.tw/program/support/download/dld/spt_dld_detail.php?UID=607&kind=6

Btw, I thought, that ehci-hcd driver handles both usb 2.0 and 1.1. Does it?

-- 
Luká¹ Hejtmánek
