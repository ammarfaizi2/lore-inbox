Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285314AbRLFXaA>; Thu, 6 Dec 2001 18:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285318AbRLFX3p>; Thu, 6 Dec 2001 18:29:45 -0500
Received: from mercury.Sun.COM ([192.9.25.1]:24228 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S285316AbRLFX3Y>;
	Thu, 6 Dec 2001 18:29:24 -0500
Message-ID: <3C0FFF22.83E28C0@sun.com>
Date: Thu, 06 Dec 2001 15:28:34 -0800
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arjanv@redhat.com, saw@sw-soft.com, sparker@sparker.net
Subject: Re: [PATCH] eepro100 - need testers
In-Reply-To: <E16C81m-0003Zm-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Works for me. Its the first eepro100 driver that wont choke eventually on
> my i810 board and its also the only one that will recover the board after
> a soft boot when it had previously started spewing errors


woohoo!  Glad to know, thanks Alan.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
