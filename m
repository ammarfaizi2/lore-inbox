Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285719AbRLYTOI>; Tue, 25 Dec 2001 14:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285730AbRLYTN7>; Tue, 25 Dec 2001 14:13:59 -0500
Received: from tourian.nerim.net ([62.4.16.79]:45585 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S285719AbRLYTNs>;
	Tue, 25 Dec 2001 14:13:48 -0500
Message-ID: <3C28CFEA.1010808@free.fr>
Date: Tue, 25 Dec 2001 20:13:46 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011220
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniela Engert <dani@ngrt.de>, linux-kernel@vger.kernel.org
Cc: Chris Shutters <cshutters@ebiz-tech.com>
Subject: Re: [RFC] SIS5513 ATA100 support
In-Reply-To: <3C27B02B.7070804@free.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:

> 
> 
> here's my first patch to sis5513.c : this should set the correct timings 
> for ATA100 chips (and hopefully say goodbye to heavy fs corruption in 
> UDMA modes).
> 


Problem not yet solved. I'm back to the drawing board but now I have a 
"reliable" way of triggering the problem.


> It compiles cleanly but is **not yet tested**.

 >

> If there's an obvious mistake please tell me 


Don't know yet if it's obvious, but there's one.

> 
> If others want to have a look or even (I repeat **not yet tested**) try 
> this code **on backuped data** they're more than welcome.
> 


Having a look at the code is always welcome. But don't waste your time 
and data testing...


> If you want to have a quick look at the whole new sis5513.c :
> 
> http://gyver.homeip.net/sis5513.c
> 
> 


LB

