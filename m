Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289582AbSAOOFX>; Tue, 15 Jan 2002 09:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289585AbSAOOFL>; Tue, 15 Jan 2002 09:05:11 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:43743 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289582AbSAOOE7>;
	Tue, 15 Jan 2002 09:04:59 -0500
Message-ID: <3C443685.70305@debian.org>
Date: Tue, 15 Jan 2002 15:02:45 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@aunt-tillie.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, esr@thyrsus.com
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
In-Reply-To: <fa.fslncfv.r6o11i@ifi.uio.no> <fa.hqe5uev.c60cjs@ifi.uio.no> <3C4427F6.3010703@debian.org> <20020115135756.A19738@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Jan 2002 14:04:57.0632 (UTC) FILETIME=[9D51BA00:01C19DCD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

 
> All of us get the CPU wrong. By using modules however I don't have to guess
> the PCI devices. My system already did that. I just need the configurator
> to hit M a lot and to work out which root devices are for the initrd.
> 
> The code for that exists


It is easier to get autoconfigure in linux sources, than
modify the default (and broken) configuration from Linus.
(Sorry Linus :-) )

 	giacomo


