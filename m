Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273904AbRIXNaD>; Mon, 24 Sep 2001 09:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273908AbRIXN3w>; Mon, 24 Sep 2001 09:29:52 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:33802 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273904AbRIXN3k>;
	Mon, 24 Sep 2001 09:29:40 -0400
Date: Mon, 24 Sep 2001 10:29:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: Andrea Arcangeli <andrea@suse.de>, Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux VM design
In-Reply-To: <6514162334.20010924123631@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L.0109241027070.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33L.0109241027072.19147@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Sep 2001, VDA wrote:

> I'd like to understand Linux VM but there's not much in
> Documentation/vm/* on the subject.

http://linux-mm.org/ has some stuff and I wrote a freenix
paper on the subject as well http://www.surriel.com/lectures/.

> Since we reached some kind of stability with 2.4, maybe
> Andrea, Rik and whoever else is considering himself VM geek
> would tell us not-so-clever lkml readers how VM works and put it in
> vm-2.4andrea, vm-2.4rik or whatever in Doc/vm/*,
> I will be unbelievably happy. Matt Dillon's post belongs there too.

http://linux-mm.org/

The only thing missing is an explanation of Andrea's
VM, but knowing Andrea's enthusiasm at documentation
I wouldn't really count on that any time soon ;)

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

