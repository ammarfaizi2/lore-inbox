Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271886AbRHUXEn>; Tue, 21 Aug 2001 19:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271888AbRHUXEe>; Tue, 21 Aug 2001 19:04:34 -0400
Received: from pD9004A55.dip.t-dialin.net ([217.0.74.85]:2564 "EHLO
	melchior.ranmachan.dyndns.org") by vger.kernel.org with ESMTP
	id <S271886AbRHUXEX>; Tue, 21 Aug 2001 19:04:23 -0400
Date: Wed, 22 Aug 2001 01:04:27 +0200
From: Tobias Diedrich <ranma@gmx.at>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
Message-ID: <20010822010427.A1003@router.ranmachan.dyndns.org>
Mail-Followup-To: Tobias Diedrich <ranma@gmx.at>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20010821223724.A588@router.ranmachan.dyndns.org> <E15ZJYE-0000N8-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15ZJYE-0000N8-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> Looks like the change int he usb_start_wait_urb code is a problem. 

When I back out the change as Pete Zaitcev suggested it's working.

-- 
Tobias							     PGP-Key: 0x9AC7E0BC
