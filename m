Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275759AbRI0Eb2>; Thu, 27 Sep 2001 00:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275760AbRI0EbS>; Thu, 27 Sep 2001 00:31:18 -0400
Received: from pool-141-151-142-74.pitt.east.verizon.net ([141.151.142.74]:63471
	"HELO jmcmullan") by vger.kernel.org with SMTP id <S275759AbRI0EbC>;
	Thu, 27 Sep 2001 00:31:02 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Jason McMullan <jmcmullan@linuxcare.com>
Newsgroups: local.linux.kernel
Subject: Re: Why is Device3Dfx driver (voodoo1/2) not in the kernel?
Date: 27 Sep 2001 04:28:52 GMT
Organization: Matrix Fire Systems
Distribution: local
Message-ID: <9ou9u4$ee6$1@localhost.localdomain>
In-Reply-To: <E15jmx4-0003bf-00@the-village.bc.nu>
NNTP-Posting-Host: localhost.localdomain
X-Trace: localhost.localdomain 1001564932 14790 127.0.0.1 (27 Sep 2001 04:28:52 GMT)
X-Complaints-To: news@localhost
NNTP-Posting-Date: 27 Sep 2001 04:28:52 GMT
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.10 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Because it lets anyone crash the machine by feeding a Voodoo1 garbage. To
> get something like that into the kernel I suspect would involve
>
> -	Making sure glide is using the fifo
> -	Writing a parser for packet1-packet5 commands to verify they 
> 	are valid
>
> then voodoo would be safe for user direct access.

	Better stop that this minute Alan! You're starting
to sound like those old KGI people, with their 'safe kernel
drivers for video' spiel... ;^)


-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
