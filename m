Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136680AbREAR5w>; Tue, 1 May 2001 13:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136683AbREAR5m>; Tue, 1 May 2001 13:57:42 -0400
Received: from [209.202.46.62] ([209.202.46.62]:2176 "HELO fluke.haryan.to")
	by vger.kernel.org with SMTP id <S136680AbREAR5Y>;
	Tue, 1 May 2001 13:57:24 -0400
Date: Tue, 1 May 2001 12:57:21 -0500
From: Ronny Haryanto <ronny-linux@haryan.to>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip driver broken in 2.4.4?
Message-ID: <20010501125721.A1734@haryan.to>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010501110512.A8148@haryan.to> <3AEEE16E.52A9F4D1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEEE16E.52A9F4D1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 01, 2001 at 12:16:46PM -0400
X-GPG-Key: Get my public key from http://ronny.haryan.to/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-May-2001, Jeff Garzik wrote:
> Ronny Haryanto wrote:
> > 
> > Just tried 2.4.4 yesterday and found that my eth1 was dead after 5 minutes.
> 
> Does 2.4.3 work for you?

Yes. I just tried 2.4.3, and it works fine. So it looks like there's a bug
introduced between 2.4.3 and 2.4.4. Too bad I can't use 2.4.3; I need 2.4.4
due to the VIA chipset bug. Is there any other info that I could provide
from here to help debugging?

Ronny
