Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTBXPfH>; Mon, 24 Feb 2003 10:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbTBXPfH>; Mon, 24 Feb 2003 10:35:07 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:61595 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id <S264711AbTBXPfG>;
	Mon, 24 Feb 2003 10:35:06 -0500
Subject: Re: AGP backport from 2.5 to 2.4.21-pre4
From: Stian Jordet <liste@jordet.nu>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030224104256.GA21385@codemonkey.org.uk>
References: <200302220716.54218.toptan@EUnet.yu>
	 <JJEJKAPBMJAOOFPKFDFKKEKACEAA.camber@yakko.cs.wmich.edu>
	 <20030224104256.GA21385@codemonkey.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1046101518.893.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 16:45:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

man, 2003-02-24 kl. 11:42 skrev Dave Jones:
> On Sat, Feb 22, 2003 at 06:07:46PM -0500, Edward Killips wrote:
>  >  
>  > The apeture is now set correctly. The ATI 4.2.0-2.5.1 drivers don't work but I 
>  > think that is a dri problem. Everything works fine with the vesa drivers using XFree86 4.2.99.
> 
> The ATI drivers rely on some additional changes to agpgart.
> I've not yet figured out exactly what it is they're trying to do,
> and as the code is quite messy, I haven't found the motivation^Wstomach
> to go back and look at their code.
Well, you would be my hero for all eternity if you found out :)

Regards,
Stian Jordet

