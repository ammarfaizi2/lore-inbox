Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288238AbSAXRlI>; Thu, 24 Jan 2002 12:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288660AbSAXRk5>; Thu, 24 Jan 2002 12:40:57 -0500
Received: from www.transvirtual.com ([206.14.214.140]:8974 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S288238AbSAXRkv>; Thu, 24 Jan 2002 12:40:51 -0500
Date: Thu, 24 Jan 2002 09:40:30 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Pavel Machek <pavel@suse.cz>
cc: Guillaume Boissiere <boissiere@mediaone.net>, linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  January 17, 2001
In-Reply-To: <20020121123936.D37@toy.ucw.cz>
Message-ID: <Pine.LNX.4.10.10201240937490.28447-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi!
> 
> > o Planning Porting all input devices over to input API  (James Simmons)
> 
> Heh, it is merged in -dj kernels. Make this "ready".

Yeap!! I ask all maintainers that deal with keyboards please port over your 
keyboad drivers over to the input API. In the near future the console system 
will be moving to use only the input api. 

