Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263348AbTDLR7N (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 13:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTDLR7N (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 13:59:13 -0400
Received: from anvers-smtp.planetinternet.be ([195.95.30.152]:4115 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id S263348AbTDLR7M (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 13:59:12 -0400
From: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
To: Mark Watts <m.watts@mrw.demon.co.uk>
Subject: Re: stabilty problems using opengl on kt400 based system
Date: Sat, 12 Apr 2003 20:10:52 +0200
User-Agent: KMail/1.5.1
References: <200304121410.58522.frank.vandamme@student.kuleuven.ac.be> <200304121608.33357.m.watts@mrw.demon.co.uk>
In-Reply-To: <200304121608.33357.m.watts@mrw.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304122010.52375.frank.vandamme@student.kuleuven.ac.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 April 2003 17:08, Mark Watts wrote:
> I'm running a KT400 based board (MSI KT4 Ultra) with a GeForce 4 Ti4200
> (agp 4x) on a custom compiled Mandrake 2.4.21 kernel.
> I regularly play games such as Unreal Tournament / UT 2003 and Neverwinter
> Nights and I have to say that stability and performance is excelent.
>
> I'm running Mandrake 9.0 which includes X 4.2.1, along with the latest
> nVidia binary drivers.
>
> I certainly don't see any of the kind of application/X crash you are
> reporting. In fact, I've played NWN for most of a day with nothing going
> wrong that can't be attributed to the beta status of the game (the game
> doesn't crash, I just get some graphical glitches which are fixed by
> reloading a saved game).
>
> If I can be of any more assistance, shout.

I am not sure, but I though nVidia cards were different. I have used a tnt2 
before I had my radeon (I used it with that previous motherboard) and back 
then, I have been advised to compile kernels without AGP support since the 
nVidia drivers wouldn't use them anyway (despite the fact that it was a 4x 
agp card). NVidia seems to have his own method of accessing the agp bus.

-- 
Frank Van Damme    | "Saying 8MB of RAM doesn't do as much anymore is
http://www.        | like saying a gallon of water holds more than it
openstandaarden.be | did in 1988."                    --George Adkins

