Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753190AbWKFOSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbWKFOSX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753192AbWKFOSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:18:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16830 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1753190AbWKFOSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:18:22 -0500
Subject: Re: 2.6.18.2: lockdep warnings on rmmod ohci_hcd
From: Arjan van de Ven <arjan@infradead.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200611061546.48062.arvidjaar@mail.ru>
References: <200611061546.48062.arvidjaar@mail.ru>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 15:18:15 +0100
Message-Id: <1162822695.3138.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 15:46 +0300, Andrey Borzenkov wrote:
> I presume this is lockdep; this looks initially truncated,
> unfortunately this 
> is how it was stored in messages. I will try to get more complete
> output ig 
> required. 

the interesting bits are missing unfortunately (the first 10 lines or
so).

Also this will be in "dmesg" if your system actually survives...

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

