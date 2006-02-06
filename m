Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWBFRpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWBFRpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWBFRpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:45:33 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:1040 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S932244AbWBFRpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:45:32 -0500
Date: Mon, 6 Feb 2006 18:45:31 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060206174531.GF31314@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <200602060824.04945.david-b@pacbell.net> <20060206165014.GC31314@epio.fluido.as> <200602060931.15239.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <200602060931.15239.david-b@pacbell.net>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: Mon 06 Feb 06 09:31:14AM -0800

Quoting David Brownell (david-b@pacbell.net):

> Then if disabling that code which enables the SMI doesn't work,
> you have only one real option other than telling your BIOS not
> to support USB keyboards/mice/disks:  replace your BIOS.

Sapphire has no newer bios than the one I am using. But I am saying
that USB works with that line commented out. I tried a couple of USB
disks, a USB mouse and my palm pilot - all seem to work quite OK. No
angry messages.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
