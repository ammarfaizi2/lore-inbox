Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264071AbRFSKQu>; Tue, 19 Jun 2001 06:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264053AbRFSKQa>; Tue, 19 Jun 2001 06:16:30 -0400
Received: from mail.mediaways.net ([193.189.224.113]:1022 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S264031AbRFSKQ2>; Tue, 19 Jun 2001 06:16:28 -0400
Date: Tue, 19 Jun 2001 11:19:55 +0200
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac15
Message-ID: <20010619111955.B2262@frodo.uni-erlangen.de>
In-Reply-To: <20010615230635.A27708@lightning.swansea.linux.org.uk> <20010617201119.A2331@frodo.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010617201119.A2331@frodo.uni-erlangen.de>; from walter.hofmann@physik.stud.uni-erlangen.de on Sun, Jun 17, 2001 at 08:11:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jun 2001, Walter Hofmann wrote:

> I had already two crashes with ac15. The system was still ping-able, but
> login over the network didn't work anymore.
> 
> The first crash happened after I started xosview and noticed that the
> system almost used up the swap (for no apparent reason). The second
> crash happened shortly after I started fsck on a crypto-loop device.
> 
> This does not happen with ac14, even under heavy load.

I had a hang with ac14 now, too. 
It hung when I tried to close a browser window after reading the text in
it for quite some time. No swapping was going on.

Walter
