Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268864AbRG0ObQ>; Fri, 27 Jul 2001 10:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRG0ObG>; Fri, 27 Jul 2001 10:31:06 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:523 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S268864AbRG0ObB>;
	Fri, 27 Jul 2001 10:31:01 -0400
Date: Fri, 27 Jul 2001 16:31:07 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: problem configuring for a mips platform
Message-ID: <20010727163107.E14483@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01072715235305.12313@edin-ios-26.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01072715235305.12313@edin-ios-26.cisco.com>; from nicbrown@cisco.com on Fri, Jul 27, 2001 at 03:23:53PM +0000
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 03:23:53PM +0000, Nick Brown wrote:
> While trying to configure the 2.4.7 kernel for cross compilation to a new 
> mips platform I get the following errors;

The mips (and mipsel) platforms are not yet fully up to date in the plain
Linus kernel. Please check out the current CVS version. For explanation
see http://oss.sgi.com/mips/mips-howto.html

MfG, JBG

