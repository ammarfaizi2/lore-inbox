Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJ2PJA>; Mon, 29 Oct 2001 10:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273783AbRJ2PIu>; Mon, 29 Oct 2001 10:08:50 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:34711 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S275857AbRJ2PIk>; Mon, 29 Oct 2001 10:08:40 -0500
Message-ID: <3BDD7164.8080401@stones.com>
Date: Mon, 29 Oct 2001 10:10:28 -0500
From: Justin Mierta <Crazed_Cowboy@stones.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, hahn@physics.mcmaster.ca,
        lung@theuw.net, linux-kernel@vger.kernel.org
Subject: Re: ECS k7s5a motherboard doesnt work
In-Reply-To: <E15y9q4-0002ER-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, i dont have a floppy drive, so that test is a little difficult to 
do, but i threw some ram in there that i have used in linux before, and 
i still had the slew of ide error messages.  and this harddrive has 
worked in linux before.  i'm getting more and more convinced its an ide 
controller +linux issue.

plus, i just discovered this:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.1/0198.html

which really points to ide controller and linux not fighting nicely 
together, altho the thread doesnt really point towards a solution.

justin


Alan Cox wrote:

>>well, i've been using it in win98 (unfortunately) and it works 
>>perfectly.  i havent even had it crash at all.  so i doubt its a 
>>hardware thing...
>>
>
>That proves absolutely nothing. Win98 stresses the system differently to
>Linux. Run test tools like memtest86 on it
>



