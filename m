Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143418AbREKXXa>; Fri, 11 May 2001 19:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143420AbREKXXV>; Fri, 11 May 2001 19:23:21 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40974 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143418AbREKXXR>; Fri, 11 May 2001 19:23:17 -0400
Subject: Re: How can I help with VIA MVP3 problems?
To: plr@udgaard.com (Peter Rasmussen (udgaard))
Date: Sat, 12 May 2001 00:19:23 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, plr@udgaard.com
In-Reply-To: <200105112241.AAA12420@udgaard.com> from "Peter Rasmussen (udgaard)" at May 12, 2001 12:41:42 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yMBv-0001oY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Supposedly there are some problems with the VIA chipsets, but apparently it
> has been better before so I wonder why it is worse now and what the plans are 
> regarding any improvement?

Until the past few -ac releases we accidentally turned off things on the older
VIA chipsets (with a performance hit) as well as the actual problem components.

