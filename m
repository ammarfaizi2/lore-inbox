Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310292AbSCBDAo>; Fri, 1 Mar 2002 22:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310293AbSCBDAg>; Fri, 1 Mar 2002 22:00:36 -0500
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:44766 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S310292AbSCBDAZ>; Fri, 1 Mar 2002 22:00:25 -0500
Message-ID: <3C8040F2.9060208@wanadoo.fr>
Date: Sat, 02 Mar 2002 04:03:14 +0100
From: eddantes@wanadoo.fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011126 Netscape6/6.2.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SSSCA: We're in trouble now
In-Reply-To: <Pine.LNX.4.05.10203021402030.4035-100000@marina.lowendale.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Neale Banks wrote:

[snip]

 > All too true.  However, given the quality of BIOS code we have seen
 > over the years, the thought of your average BIOS programmer
 > implementing cryptographic techniques does provide some amusement
 > ;-)


PnP crypto? I'd love to see it. :)
That could actually be used somehow as some sort of pseudo-random 
generator, given the legendary oh-so-predictable behaviour of most 
BIOSes, even in normal circumstances... :D


 > Any chance of any manafacturers open-sourcing their BIOS?


Uhmm... Odds: 1 in <buffer overflow>
Considering that they seem to see BIOSes as the easiest way to hide 
hardware design mistakes, they probably wont.

OTOH, why not sticking Linux straight into BIOS flash chips?
Have a look here (sorry if you already knew):
http://www.linuxbios.org/
http://freebios.sourceforge.net/

Or just implement an OpenFirmware BIOS (that's cool! :)?
http://www.freiburg.linux.de/openbios/


 > Regards, Neale.


All hope is not lost! ;)

Have fun.
/Dantes

