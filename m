Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282498AbRLKUPx>; Tue, 11 Dec 2001 15:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282525AbRLKUPo>; Tue, 11 Dec 2001 15:15:44 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:52208 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282498AbRLKUPb>; Tue, 11 Dec 2001 15:15:31 -0500
Date: Tue, 11 Dec 2001 21:52:04 +0100
From: David Odin <dindinx@wanadoo.fr>
To: Samuel Maftoul <maftoul@esrf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT?] SuSe kernel
Message-ID: <20011211215204.A26123@wanadoo.fr>
In-Reply-To: <20011211193048.A22075@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20011211193048.A22075@pcmaftoul.esrf.fr>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 07:30:48PM +0100, Samuel Maftoul wrote:
> In SuSe's kernel there is a nice feature but I cannot  found where is
> the code that does it and so I cannot play with it 8-).
> The thing I'm talking about is grpahical boot + graphical first console.
> I glanced at include/asm-i386/linux_logo.h but it doesn't differ.
> Can someone help me ?
>         Sam

  This is the so-called Linux-Progress-Patch created by Cajus Pollmeier.
You can grab it there: http://lpp.FreeLords.org/

I've adapted it for newer kernel. See this: http://www.dindinx.org/lpp

 Regards,
  
              DindinX

-- 
David@dindinx.org
