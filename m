Return-Path: <linux-kernel-owner+w=401wt.eu-S1751323AbXAIMNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbXAIMNK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 07:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXAIMNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 07:13:10 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:47460 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751323AbXAIMNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 07:13:09 -0500
Message-ID: <45A38652.7010204@aitel.hist.no>
Date: Tue, 09 Jan 2007 13:10:58 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Dirk <d_i_r_k_@gmx.net>
CC: Kasper Sandberg <lkml@metanurb.dk>, Jay Vaughan <jv@access-music.de>,
       Trent Waddington <trent.waddington@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Gaming Interface
References: <45A22D69.3010905@gmx.net>	 <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com>	 <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@[192.168.2.101]>	 <45A24176.9080107@gmx.net> <45A2509F.3000901@aitel.hist.no>	 <45A264E1.3080603@gmx.net> <1168317631.3013.7.camel@localhost> <45A342AC.9080507@gmx.net>
In-Reply-To: <45A342AC.9080507@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dirk wrote:
> Kasper Sandberg wrote:
>>
>> so in the grand scheme, the things you are suggesting are completely a
>> wrong solution, and furthermore, a solution to a problem that does not
>> exist.
>>
>
> If there is no problem with Linux gaming I should shut the hell up and 
> start buying all these Linux games I keep hearing about and seeing in 
> those TV commercials.
Come on!  We agree that there aren't many games to buy on linux.
We just disagree a bit on why.
You suggest a standard API in the kernel.  You have been informed
why this can't be in the kernel, and that well-supported standard APIs for
linux games exists already anyway.  Perhaps the documentation could be
improved - you were probably not the only one who didn't know
that opengl+SDL is the way to do games on linux.

The reason you see so few games on linux is _not_ lack of support
for game programmers in linux.  The support is there,
it has been there for a long time - and that
is why we have 3D games like ppracer and quake on linux.

The reason there isn't many commercial games for linux is that
desktop linux is a smaller market than desktop windows.  Linux
is big on servers but few people play games on those.

We could port directx today and there still wouldn't be that many
linux games.  This will change only as home limux becomes more popular.
And then we'll get linux games no matter what the programmers will
have to do to make them work. The problem is market share - not
technology.



Another thing - why worry about those commercial games anyway?
It is not as if linux lack games, the only problem might be how to pay
for them. ;-) 
On debian, the following command counts over 400 game titles:
apt-cache search game | grep -v lib | grep game | wc

Helge Hafting
