Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286111AbRLZBBU>; Tue, 25 Dec 2001 20:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286143AbRLZBBK>; Tue, 25 Dec 2001 20:01:10 -0500
Received: from pop.gmx.de ([213.165.64.20]:61190 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286140AbRLZBBB>;
	Tue, 25 Dec 2001 20:01:01 -0500
Date: Wed, 26 Dec 2001 01:59:50 +0100
From: Christian Ohm <chr.ohm@gmx.net>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011226005950.GB3970@moongate.thevoid.net>
In-Reply-To: <20011224010450.GB1482@moongate.thevoid.net> <Pine.LNX.4.33.0112232355540.5312-100000@coffee.psychology.mcmaster.ca> <20011225003901.GA3752@moongate.thevoid.net> <01122510384005.01845@manta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01122510384005.01845@manta>
User-Agent: Mutt/1.3.24i
Organization: theVoid
X-Operating-System: Linux moongate 2.4.17 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Force Athlon bug stomper to be executed at startup (look into pci-pc.c).
> Your kernel thinks you don't need it. It may be wrong.
> Please report back.

like i said, i don't really think this is hardware related, unless someone
convinces me of the opposite. anyway, first i'll try to reproduce it to be
sure 2.4.17 still behaves this way. then comes the fun part: searching for
the cause...

bye
christian ohm
