Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263308AbRFABcz>; Thu, 31 May 2001 21:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbRFABcp>; Thu, 31 May 2001 21:32:45 -0400
Received: from serval.noc.ucla.edu ([169.232.10.12]:56566 "EHLO
	serval.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S263300AbRFABcf>; Thu, 31 May 2001 21:32:35 -0400
Message-ID: <3B16F0F8.7020403@ucla.edu>
Date: Thu, 31 May 2001 18:33:44 -0700
From: Benjamin Redelings I <bredelin@ucla.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac9 i686; en-US; rv:0.9+) Gecko/20010531
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Plain 2.4.5 VM... (and 2.4.5-ac3)]
Content-Type: multipart/mixed;
 boundary="------------050706060300000807030507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050706060300000807030507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a message from Steve Kieu that he couldn't get through...
-- 
Einstein did not prove that everything is relative.
Einstein explained how the speed of light could be constant.
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/

--------------050706060300000807030507
Content-Type: message/rfc822;
 name="Re: Plain 2.4.5 VM... (and 2.4.5-ac3)"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: Plain 2.4.5 VM... (and 2.4.5-ac3)"


>From - Thu May 31 14:25:54 2001
X-Mozilla-Status2: 00000000
Return-path: <haiquy@yahoo.com>
Received: from serval.noc.ucla.edu by cougar.noc.ucla.edu
 (Sun Internet Mail Server sims.3.5.2000.03.23.18.03.p10)
 with ESMTP id <0GE700E5EXZAE2@cougar.noc.ucla.edu> for
 bredelin@sims-ms-daemon; Thu, 31 May 2001 14:21:10 -0700 (PDT)
Received: from web10407.mail.yahoo.com
 (web10407.mail.yahoo.com [216.136.130.99])
 by serval.noc.ucla.edu (8.9.1a/8.9.1) with SMTP id OAA24737 for
 <bredelin@ucla.edu>; Thu, 31 May 2001 14:21:09 -0700 (PDT)
Received: from [203.97.2.242] by web10407.mail.yahoo.com; Fri,
 01 Jun 2001 07:21:09 -0500 (EST)
Date: Fri, 01 Jun 2001 07:21:09 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
In-reply-to: <3B167DF6.7020804@ucla.edu>
To: Benjamin Redelings I <bredelin@ucla.edu>
Message-id: <20010531212109.86230.qmail@web10407.mail.yahoo.com>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8bit


Just add my experience here...

I use up to 2.4.4 and it is fine ; swap usage increase
much but only in 2.4.5-acx IMHO it is because Alan did
some changes?

test with staroffice 5.1 in 35Mb RAM 32M swap 100Mhz 
just start staroffice and check, then exit check

kernel		usage	usage when exit	  time (sec)
2.4.4-pre4	2.5M	2.5M		   48
2.4.4		2.0M	2.0M		   48
2.4.5		3.5M	3.5M		   49
2.4.5-ac1	7.9M	7.9M		   49		

In 2.4.4 and 2.4.4-pre4 I noticed the kernel DID free
swap when it needs. For example when I ran netscape
for a while typing email in a web mail form (that way
netscape will make memory leak) swap usage sometimes
17M. Quit netscape it reduced to about 12M; of course
leave a lot free memory). Start netscape again SWAP
REDUCED TO about 2M , just a bit bigger at the fisrt
time I start netscape.

Steve

--- Benjamin Redelings I <bredelin@ucla.edu> wrote: >
Vincent Stemen wrote:
>  > The problem is, that's not true.  These problems
> are not slipping
>  > through because of lack of testers.
> 	Just to add some sanity to this thread, I have been
> using the 2.4.x 
> kernels ever since they came out, on my personal
> workstation and on some 
> workstations that I administrate for fellow students
> in my department 
> here at UCLA.  They have basically worked fine for
> me.  They are not 
> perfect, but many of the 2.4.x releases have been a
> big improvement over 
> the 2.2.x releases.  For one, 2.4.x actually can
> tell which pages are 
> not used, and swap out unused daemons, which helps a
> lot on a 64Mb box :)
> 	
> -BenR
> -- 
> Einstein did not prove that everything is relative.
> Einstein explained how the speed of light could be
> constant.
> Benjamin Redelings I      <><    
> http://www.bol.ucla.edu/~bredelin/
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


=====
S.KIEU

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!


--------------050706060300000807030507--

