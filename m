Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269503AbRHLW3L>; Sun, 12 Aug 2001 18:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269491AbRHLW3C>; Sun, 12 Aug 2001 18:29:02 -0400
Received: from sproxy.gmx.de ([194.221.183.20]:838 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S269490AbRHLW2m>;
	Sun, 12 Aug 2001 18:28:42 -0400
Message-ID: <3B7700F1.91A3ECB2@gmx.de>
Date: Mon, 13 Aug 2001 00:19:29 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: SNES controllers
In-Reply-To: <20010812144212.A4270@tentacle.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:
> 
> Under Documentation/joysticj-parport.txt there is a description of
> how to build an adapter for attaching SNES/NES control pads to
> the parallel port. It says to use diodes. I am wondering what
> kind of diodes should I use?

1N4148

> aswell is it safe to bridge pin's 4 - 9 together with diodes to get
> more power?

Yes.

Ciao, ET.
