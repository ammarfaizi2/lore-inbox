Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316674AbSE0Q01>; Mon, 27 May 2002 12:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316675AbSE0Q00>; Mon, 27 May 2002 12:26:26 -0400
Received: from www.cdhutmusic.com ([196.28.7.66]:10125 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316674AbSE0Q00>; Mon, 27 May 2002 12:26:26 -0400
Date: Mon, 27 May 2002 17:59:54 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Eric Lemoine <Eric.Lemoine@ens-lyon.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i8259 and IO-APIC
In-Reply-To: <1022510160.12202.113.camel@pc-16.office.scali.no>
Message-ID: <Pine.LNX.4.44.0205271757550.28930-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 May 2002, Terje Eggestad wrote:

> Do you got any numbers that state that it's processing overhead, and not
> HW latency that is the bulk of interrupt service time? Just curious,
> I've been looking and can't find this "perceived fact" backed up by
> facts anywhere. 

I think Alan had the ISR and kernel IRQ service overhead in mind. In this 
light, hardware interrupt latency is a drop in the ocean..

Cheers,
	Zwane Mwaikambo
-- 
http://function.linuxpower.ca
		


