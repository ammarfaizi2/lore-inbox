Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319091AbSHMWlk>; Tue, 13 Aug 2002 18:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319092AbSHMWlk>; Tue, 13 Aug 2002 18:41:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5648 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319091AbSHMWlk>; Tue, 13 Aug 2002 18:41:40 -0400
Date: Tue, 13 Aug 2002 15:46:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Dobson <colpatch@us.ibm.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Greg KH <gregkh@us.ibm.com>
Subject: Re: [patch] PCI Cleanup
In-Reply-To: <3D598852.4070404@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0208131545500.1277-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Matthew Dobson wrote:
> 	I think I'm getting what you're aiming for here.  See if this patch comes close 
> to what you're looking for.

This seems to be more what I was thinking of, yes (although please drop 
the "size_independent" part of the names, that just looks too horrible ;)

		Linus

