Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131446AbREHHSr>; Tue, 8 May 2001 03:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131457AbREHHSh>; Tue, 8 May 2001 03:18:37 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:5132 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131446AbREHHSU>;
	Tue, 8 May 2001 03:18:20 -0400
Date: Tue, 8 May 2001 09:18:11 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, alexander.eichhorn@rz.tu-ilmenau.de,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
Message-ID: <20010508091811.C17720@pcep-jamie.cern.ch>
In-Reply-To: <E14wlUi-0003WQ-00@the-village.bc.nu> <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010507121212.4256A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, May 07, 2001 at 12:12:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> However, PCI to memory copying runs at about 300 megabytes per
> second on modern PCs and memory to memory copying runs at over 1,000
> megabytes per second. In the future, these speeds will increase.

That would be "big expensive modern PCs" then.  Our clusters of 700MHz
boxes are strictly limited to 132 megabytes per second over PCI...

-- Jamie
