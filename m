Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbTCZUNi>; Wed, 26 Mar 2003 15:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbTCZUNi>; Wed, 26 Mar 2003 15:13:38 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:51206 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262054AbTCZUNf>; Wed, 26 Mar 2003 15:13:35 -0500
Date: Wed, 26 Mar 2003 20:24:46 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Toplica Tanaskovic <toptan@EUnet.yu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
In-Reply-To: <200303251051.36023.toptan@EUnet.yu>
Message-ID: <Pine.LNX.4.44.0303262024270.21188-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > For console resizing try using stty cols xxx rows xx.
> >
> 	Tried.  Not working again. Last line of the text is at same position like 
> when changing mode with fbset, upper lines are now on the right where garbage 
> is when using fbset.
> 	First scrolling gives an oops, but due to screen corruption I could not write 
> down message displayed. Nothing in logs due to irregular reboot.

I seen this bug. I fixed it in BK.


