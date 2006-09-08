Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWIHTDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWIHTDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWIHTDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:03:53 -0400
Received: from main.gmane.org ([80.91.229.2]:15809 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750756AbWIHTDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:03:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: LKML FAQ, newsgroups and newbies (was Re: [RFC] e-mail clients)
Date: Fri, 08 Sep 2006 22:03:48 +0200
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <4501CCA4.1000100@flower.upol.cz>
References: <4500B2FB.8050805@vhugo.net> <9a8748490609080124q5b32d325l1c251d3e2d800f1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Victor Hugo <victor@vhugo.net>
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <9a8748490609080124q5b32d325l1c251d3e2d800f1d@mail.gmail.com>
X-Image-Url: http://flower.upol.cz/~olecom/upol-cz.png
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 08/09/06, Victor Hugo <victor@vhugo.net> wrote:
>> about which client to use on lkml?? Pine?? Mutt??
>> Thunderbird?? Telnet??
>>
> I personally use both 'pine' and 'kmail' and they both work perfectly
> for sending patches.
> 

Why NNTP was abandoned and development switched to pure SMTP+maillist ?

Pros and cons are. Classic NNTP consider "courtesy copies" (Cc) to be impolite,
pure SMTP eases scripting of handling patches. But, adding CCs to NNTP postings 
is possible, while reading big volumes is very convenient. Any backend SMTP 
MUA/MTA may be used for patch-handling job. Discussion about (any web-based) 
bugzilla vs e-mail, applies to NNTP: there are many readers (with e-mail 
support as well), easy managing, ASCII.

IMHO it's very good start for anyone. Thus i've found a way to step into 
development even i'm not cs, guru, hacker, just unix-like os (stupid) user, 
even have had read all that treating discussions about lkml volumes.

I use Mozilla-newsreader-gmane.org + SMTP MTA | mutt MUA, but couldn't yet 
develop patch handling, i didn't write a good one yet.

So things like:
* press articles' questions "It's so many messages in LKML, how one can read
   them all ???",
* SMTP@spam (key is _@_ ;),
* e-mail handling headache,
   is prize for not using NNTP as a primary. I really want to see reasonable
   explanations on question above. FAQ has "COLA = comp.os.linux.announce
   (newsgroup)", nothing more about NNTP as it used to be used.

-*- OT -*-

On every LKML post there's a message about FAQ URL, that page has
"NOTE: this page is no longer maintained..." (Dot coms boomed) Many 
linux-related sites also outdated. Advogato is going down (well most of linux 
developers moved from it years ago), we are getting older, having families, 
children, something becomes more/less important. So that's next ? (hopefully 
not an accelerated kernel-XML-Parser 4 Desktop Linux (R) ;)

Maybe linux-kernel need new blood ? Victor Hugo, being not from 
linux-visionaries, you're welcome.

-- 
-o--=O`C  /. .\  (i want ..., but with ENOPATCH) (+)
  #oo'L O      o					  |
<___=E M    ^--                                   | (you're ... the wrong ...)

