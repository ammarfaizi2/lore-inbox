Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286327AbRLJRW5>; Mon, 10 Dec 2001 12:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286325AbRLJRWs>; Mon, 10 Dec 2001 12:22:48 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:35335 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S286328AbRLJRWd>;
	Mon, 10 Dec 2001 12:22:33 -0500
Message-ID: <3C14EF57.7070801@epfl.ch>
Date: Mon, 10 Dec 2001 18:22:31 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patches in 2.4.17-pre2 that aren't in 2.5.1-pre8
In-Reply-To: <Pine.LNX.4.21.0112101348470.25093-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> Nicolas, 
> 
> Who is the maintainer of the driver ?


According to the 'MAINTAINERS' file, nobody. So everything related to 
the topic goes through you :-)


> Try to think from my side: I may have no hardware or time to test all
> patches which come to me.


That's why I did not pressed you. I sent you the patch something like 
two weeks ago, but I know you have a very big amount of email, and many 
other things to test/apply/reject/whatever. I just noticed that what I 
sent to you and Linus had been merged into the 2.5 tree, which motivated 
my reply, just to know the state of the


> Please, people, send this kind of driver changes to the people who know
> all hardware specific details.


As stated previously, there is no one for this... I only got positive 
feedback about my patches by Robert Love, but as you he did not have the 
hardware/time to test.


> If there is no maintainer for i810, I'll be glad to apply it on 2.4.18pre
> and wait for reports. Not going to be on 2.4.17, though.
> 

You're the boss ;-) As I said, I got at least 3 successful feedbacks for 
this patch, and the fact that Linux got it into the tree kinda confirms 
my thought that there might not be too many things broken in it. The 
choice of putting it into 2.4.17 or 2.4.18 is entirely yours, and I 
accept it whatever it is. Keep me informed ;-)

Best regards

-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)

