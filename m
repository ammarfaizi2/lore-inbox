Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282670AbRLBCDg>; Sat, 1 Dec 2001 21:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282672AbRLBCD1>; Sat, 1 Dec 2001 21:03:27 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:27820
	"HELO tabris.net") by vger.kernel.org with SMTP id <S282670AbRLBCDK>;
	Sat, 1 Dec 2001 21:03:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Schrotenboer <ajschrotenboer@lycosmail.com>
Organization: Dome-S-Isle Data
To: Miguel Maria Godinho de Matos <Astinus@netcabo.pt>,
        linux-kernel@vger.kernel.org
Subject: Re: SENDMAIL Ages to start !!!!!
Date: Sat, 1 Dec 2001 21:02:56 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <EXCH01SMTP01fVwcdZ0000059be@smtp.netcabo.pt>
In-Reply-To: <EXCH01SMTP01fVwcdZ0000059be@smtp.netcabo.pt>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011202020257.3C083FB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 December 2001 20:29, Miguel Maria Godinho de Matos wrote:
> I am having some prblems with sendmail since the second time i booted
> linux.
>
> I have linux for about 2 months now and i just now understood that my send
> mail deamon takes too long to start.
>
> this is the log message that appeard when i upgraded linux red hat 7.1 to
> 7.2 for the first time:
Beware of scripts that claim to fix the /etc/hosts file. (Mandrake 8.1 cups 
script[confirmed], among other possibilites. one ugly sol'n is to make 
/etc/hosts immutable [chattr +i /etc/hosts]. Risky, and needs to be root to 
do it. But immutable stops even root from modifying the file. Of course, do 
this after fixing it. Also, try fixing it so it is a real domain name. like 
astinusgod.pt [or whatever u hope to have as your domain name someday])

I used to have this problem too w/ Mandrake.

HTH

-- 
tabris

   A man alone is easy prey

                                              Clint Eastwood - Pale Rider

