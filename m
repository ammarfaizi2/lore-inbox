Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262968AbTCWIi6>; Sun, 23 Mar 2003 03:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262976AbTCWIi6>; Sun, 23 Mar 2003 03:38:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2828 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262968AbTCWIi5>;
	Sun, 23 Mar 2003 03:38:57 -0500
Date: Sun, 23 Mar 2003 00:49:50 -0800
From: Greg KH <greg@kroah.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] More i2c driver changes for 2.5.65
Message-ID: <20030323084950.GL26145@kroah.com>
References: <1048295082521@kroah.com> <1048295084971@kroah.com> <20030322023351.GB2050@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030322023351.GB2050@vana.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 03:33:51AM +0100, Petr Vandrovec wrote:
> 
> Although you'll not break matroxfb more than it is currently, can you
> also update drivers/video/matrox/{i2c-matroxfb,matroxfb_maven}.* in 
> your updates? Or I'll send you patch after this change hits Linus kernel... 

Yeah, that stuff doesn't compile at all :)

I added a patch for the i2c related stuff to my tree that I just sent
out.

thanks for pointing it out.

greg k-h
