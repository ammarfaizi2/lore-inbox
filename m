Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSFBVTJ>; Sun, 2 Jun 2002 17:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314389AbSFBVTI>; Sun, 2 Jun 2002 17:19:08 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:55444 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314340AbSFBVTH>;
	Sun, 2 Jun 2002 17:19:07 -0400
Date: Sun, 2 Jun 2002 23:18:58 +0200
From: Hanno =?ISO-8859-1?Q?B=F6ck?= <hanno@gmx.de>
To: James Mayer <james@cobaltmountain.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeon framebuffer problem
Message-Id: <20020602231858.5982571f.hanno@gmx.de>
In-Reply-To: <20020602201758.GA19815@galileo>
Organization: Mecronome Webdesign - http://www.mecronome.de/
X-Mailer: Sylpheed version 0.7.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My card is a Radeon Mobility M6 LY.
> > All kernels are with radeon framebuffer compiled in as the only
> > framebuffer.
> 
> You might want to try this, I have an M6 LY with what I suspect is the
> same problem.

That patch works! Thanks.

Any plans when it will be included into the main kernel? (I currently have to apply three patches for a working kernel ;-)
