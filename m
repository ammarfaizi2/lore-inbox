Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSCRWuU>; Mon, 18 Mar 2002 17:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293190AbSCRWuP>; Mon, 18 Mar 2002 17:50:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62737 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293205AbSCRWtW>; Mon, 18 Mar 2002 17:49:22 -0500
Date: Mon, 18 Mar 2002 14:47:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Cort Dougan <cort@fsmlabs.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020318153637.J4783@host110.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0203181446200.10517-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Mar 2002, Cort Dougan wrote:
> 
> The cycle timer in this case is about 16.6MHz.

Oh, you're cycle timer is too slow to be interesting, apparently ;(

		Linus

