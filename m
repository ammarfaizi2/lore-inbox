Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWHKRPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWHKRPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWHKRPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:15:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2272 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932223AbWHKRPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:15:24 -0400
Subject: Re: bootsplash integration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
Cc: Steve Barnhart <stb52988@gmail.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <44DCB95B.4060101@tremplin-utc.net>
References: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com>
	 <6bffcb0e0608110752v3c4a7ac3xa87739163a411a27@mail.gmail.com>
	 <15ce3ec0608110839i586e6f5cj3fd448aeddf4cddb@mail.gmail.com>
	 <44DCB95B.4060101@tremplin-utc.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 18:35:28 +0100
Message-Id: <1155317729.24077.110.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-11 am 19:07 +0200, ysgrifennodd Eric Piel:
> I just wonder if one can also put background pictures on the TTY only 
> from user-space...

Currently only easily via X11 because the knowledge of the overlay and
YUV/RGB scaler engines is in X not in the kernel.

Alan

