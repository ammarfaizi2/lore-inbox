Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSKMDGD>; Tue, 12 Nov 2002 22:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbSKMDGD>; Tue, 12 Nov 2002 22:06:03 -0500
Received: from www.txcdc.com ([65.67.58.21]:52614 "HELO escalade.vistahp.com")
	by vger.kernel.org with SMTP id <S267111AbSKMDGC>;
	Tue, 12 Nov 2002 22:06:02 -0500
Message-ID: <20021113031518.8700.qmail@escalade.vistahp.com>
References: <20021113002529.7413.qmail@escalade.vistahp.com>
            <3DD1A899.8080800@mvista.com>
            <3DD1C046.3010603@metaparadigm.com>
In-Reply-To: <3DD1C046.3010603@metaparadigm.com>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: Michael Clark <michael@metaparadigm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: md on shared storage
Date: Tue, 12 Nov 2002 21:15:18 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am testing OpenGFS on this hardware(it is on loan from OSDL), I could 
probably do some testing for you if you have some specifics you want to try. 
I am having trouble with the volume management portion of OpenGFS also(but I 
don't necessarily think they are related). 

 --Brian Jackson 


<snip>
> 
> I'm interested in finding what magic is required to get a stable
> setup with qlogic drivers and LVM. I have tested many kernel combinations,
> vendor kernels, stock, -aa and variety of different qlogic drivers
> inclusing the one with the alleged stack hog fixes and they all ooops
> when using LVM (can take up to 10 days of production load). Removing
> LVM 45 days ago and now I have 45 days uptime on these boxes. 
> 
> I'm currently building a test setup to try and excercise this problem
> as all my other boxes with qlogic cards are production and can't be
> played with. I really miss having volume management and a SAN setup
> is really where you need it the most. 
> 
> ~mc 
> 
