Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313293AbSD0L4b>; Sat, 27 Apr 2002 07:56:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313311AbSD0L4a>; Sat, 27 Apr 2002 07:56:30 -0400
Received: from AGrenoble-101-1-3-34.abo.wanadoo.fr ([193.253.251.34]:7813 "EHLO
	elessar.linux-site.net") by vger.kernel.org with ESMTP
	id <S313293AbSD0L43> convert rfc822-to-8bit; Sat, 27 Apr 2002 07:56:29 -0400
Message-ID: <3CCA9401.7040308@wanadoo.fr>
Date: Sat, 27 Apr 2002 14:05:21 +0200
From: =?ISO-8859-15?Q?Fran=E7ois_Cami?= <stilgar2k@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020417
X-Accept-Language: en-us, fr
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
Cc: Matthew M <matthew.macleod@btinternet.com>, linux-kernel@vger.kernel.org
Subject: Re: Microcode update driver
In-Reply-To: <m171QRZ-000Ga6C@Wasteland> <20020427134241.H14743@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Apr 27, 2002 at 12:32:42PM +0100, Matthew M wrote:
>  > -----BEGIN PGP SIGNED MESSAGE-----
>  > Hash: SHA1
>  > 
>  > Hi,
>  > 
>  > When I try to update the microcode on my PIV (1.7GHz, Jetway mobo), the 
>  > update fails and i see --
>  > 
>  > microcode: CPU0 no microcode found! (sig=f0a, pflags=4)
> 
> Probably the microcode.dat file has no updated microcode for this
> stepping of CPU.  Make sure you have the latest one from
> http://www.urbanmyth.org/microcode/
> 
> But it's still possible that there is no update (yet).
> 

considering that the microcode update is one year old, I don't believe
there is an update for that CPU...

François

