Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268911AbRG0Rbt>; Fri, 27 Jul 2001 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268904AbRG0Rbj>; Fri, 27 Jul 2001 13:31:39 -0400
Received: from jaws.cisco.com ([198.135.0.150]:16298 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S268905AbRG0Rb1>;
	Fri, 27 Jul 2001 13:31:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nick Brown <nicbrown@cisco.com>
Reply-To: nicbrown@cisco.com
Organization: Cisco Systems Ltd.
To: linux-kernel@vger.kernel.org
Subject: Re: problem configuring for a mips platform
Date: Fri, 27 Jul 2001 18:28:07 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01072715235305.12313@edin-ios-26.cisco.com> <20010727163107.E14483@lug-owl.de>
In-Reply-To: <20010727163107.E14483@lug-owl.de>
MIME-Version: 1.0
Message-Id: <01072718280707.12313@edin-ios-26.cisco.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001  2:31 pm, Jan-Benedict Glaw wrote:
> The mips (and mipsel) platforms are not yet fully up to date in the plain
> Linus kernel. Please check out the current CVS version. For explanation
> see http://oss.sgi.com/mips/mips-howto.html

Cheers,
that seems to work, but when I quite xconfig (saving config) I get the 
following error;

ERROR - Attempting to write value for unconfigured variable (CONFIG_VT).
ERROR - Attempting to write value for unconfigured variable (CONFIG_SERIAL).
ERROR - Attempting to write value for unconfigured variable 
(CONFIG_UNIX98_PTYS).
ERROR - Attempting to write value for unconfigured variable (CONFIG_RTC).

These check boxes behave strangly in xconfig.

Nick

-- 
Mountains have a way of dealing with overconfidence.
	-- Hermann Buhl
