Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281679AbRKZNqx>; Mon, 26 Nov 2001 08:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281680AbRKZNqo>; Mon, 26 Nov 2001 08:46:44 -0500
Received: from bashir.Belgium.EU.net ([193.74.208.147]:8396 "EHLO
	bashir.belgium.eu.net") by vger.kernel.org with ESMTP
	id <S281679AbRKZNqg>; Mon, 26 Nov 2001 08:46:36 -0500
Date: Mon, 26 Nov 2001 15:46:26 +0200
From: Ward Vandewege <ward@pong.be>
To: =?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in kernel 2.4.x with x>=12
Message-ID: <20011126154626.A4119@countzero.vandewege.net>
Mail-Followup-To: Ward Vandewege <ward@pong.be>,
	=?iso-8859-1?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011126145505.A3783@countzero.vandewege.net> <3C023E74.8090303@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C023E74.8090303@wanadoo.fr>; from stilgar2k@wanadoo.fr on Mon, Nov 26, 2001 at 02:07:00PM +0100
X-URL: http://pong.be/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 02:07:00PM +0100, François Cami wrote:
> 
> Maybe that will sound funny but... Could you try
> compiling the kernel for an i386 processor and
> report the results ?

I've compiled 2.4.16-pre1 optimized for i386 instead of Athlon/Duron, and had no problem whatsoever booting. I'm now beating it a bit, compiling a kernel etc, but it appears to be rock solid.

This seems to suggest there is a problem in the Athlon/Duron optimization code.

Thanks François!

Bye for now,
Ward Vandewege.

-- 
Pong.be         -( "Fools ignore complexity.  Pragmatists suffer it. Some  )-
Virtual hosting -(     can avoid it.  Geniuses remove it." -- Perlis's     )-
http://pong.be  -(  Programming Proverb #58, SIGPLAN Notices, Sept.  1982  )-
