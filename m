Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130388AbRCETpF>; Mon, 5 Mar 2001 14:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbRCETo4>; Mon, 5 Mar 2001 14:44:56 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:31962 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130388AbRCEToo>;
	Mon, 5 Mar 2001 14:44:44 -0500
Message-ID: <3AA3ECAA.68BA316D@mandrakesoft.com>
Date: Mon, 05 Mar 2001 14:44:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loop stuck in -D state
In-Reply-To: <Pine.LNX.4.33.0103051844390.407-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Mon, 5 Mar 2001, Richard B. Johnson wrote:
> > Now I'm in a load of trouble. I can't make a boot-disk to get back
> > to 2.4.1 because I use initrd for my hard disk modules and the loop
> > device is broken.
> 
> What's wrong with 2.4.2 that makes you want to go back?  Anyway, if
> you grab Jens' patch, all will be peachy (at least for that kind of
> basic usage).

2.4.3-pre2 should be the one to test... it should include the latest
loop fixes..

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
