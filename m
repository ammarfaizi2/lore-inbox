Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272372AbRIOPsZ>; Sat, 15 Sep 2001 11:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272373AbRIOPsP>; Sat, 15 Sep 2001 11:48:15 -0400
Received: from viper.haque.net ([66.88.179.82]:38878 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S272372AbRIOPsD>;
	Sat, 15 Sep 2001 11:48:03 -0400
Message-ID: <3BA37848.BB5851E9@haque.net>
Date: Sat, 15 Sep 2001 11:48:24 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kristian Peters <kristian.peters@korseby.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
In-Reply-To: <3BA33818.8030503@korseby.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Peters wrote:
> For about 3 weeks I sent a report that I've got very strange kernel error messages.
> 
> I changed my harddrive to IBM 75 GB because someone said that IBM's 40 GB
> harddisks are not very stable.
> 
...
> 
> The following files are always in connection with these errors:
> /var/log/wtmp
> /var/log/messages
> 
> The old hd was hda: IBM-DTLA-305040, ATA DISK drive. The new is: hda:
> IBM-DTLA-307075, ATA DISK drive.
> 
...
> 
> I currently use linux 2.4.9 and e2fsprogs 1.23 and fileutils-4.1 and a modified
> RedHat 6.2. These errors only occured with linux>=2.4.5-ac11.
> 
> I might say this is definitely an error with ext2 !


You need to provide more information such as what kind of motherboard or
ide chipset you are using. 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
