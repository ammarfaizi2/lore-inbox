Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133117AbRAGCMR>; Sat, 6 Jan 2001 21:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135302AbRAGCMI>; Sat, 6 Jan 2001 21:12:08 -0500
Received: from chmls06.mediaone.net ([24.147.1.144]:20138 "EHLO
	chmls06.mediaone.net") by vger.kernel.org with ESMTP
	id <S133117AbRAGCLv>; Sat, 6 Jan 2001 21:11:51 -0500
Message-ID: <3A57D10E.9080205@maniac.ultranet.com>
Date: Sat, 06 Jan 2001 21:14:38 -0500
From: "David C. Davies" <davies@maniac.ultranet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Andi Kleen <ak@suse.de>, Bill Wendling <wendling@ganymede.isdn.uiuc.edu>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <20001103202911.A2979@gruyere.muc.suse.de> <200011031937.WAA10753@ms2.inr.ac.ru> <20001103160108.D16644@ganymede.isdn.uiuc.edu> <3A033C82.114016A0@mandrakesoft.com> <20001104004129.C5173@gruyere.muc.suse.de> <3A0350EC.8B1A3B4D@mandrakesoft.com>
Content-Type: multipart/alternative;
 boundary="------------080100040707010804040708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------080100040707010804040708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

All,

Please reply to daviesrallis@mediaone.net rather than this email account.

Regards,

Dave
------------------------------------

Jeff Garzik wrote:

> Andi Kleen wrote:
> 
>> de4x5 is stable, but tends to perform badly under load, mostly because
>> it doesn't use rx_copybreak and overflows standard socket buffers with its
>> always MTU sized skbuffs.
> 
> 
> One of the reasons that de4x5 isn't gone already is that I get reports
> that de4x5 performs better than the tulip driver for their card.
> 
> 	Jeff
> 
> 


--------------080100040707010804040708
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<html><head></head><body>All,<br>
<br>
Please reply to <a class="moz-txt-link-abbreviated" href="mailto:daviesrallis@mediaone.net">daviesrallis@mediaone.net</a> rather than this email account.<br>
<br>
Regards,<br>
<br>
Dave<br>
------------------------------------<br>
<br>
Jeff Garzik wrote:<br>
<blockquote type="cite" cite="mid:3A0350EC.8B1A3B4D@mandrakesoft.com"><pre wrap="">Andi Kleen wrote:<br></pre>
  <blockquote type="cite"><pre wrap="">de4x5 is stable, but tends to perform badly under load, mostly because<br>it doesn't use rx_copybreak and overflows standard socket buffers with its<br>always MTU sized skbuffs.<br></pre></blockquote>
    <pre wrap=""><!----><br>One of the reasons that de4x5 isn't gone already is that I get reports<br>that de4x5 performs better than the tulip driver for their card.<br><br>	Jeff<br><br><br></pre>
    </blockquote>
    <br>
</body></html>
--------------080100040707010804040708--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
