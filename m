Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132002AbQLJSt2>; Sun, 10 Dec 2000 13:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132000AbQLJStV>; Sun, 10 Dec 2000 13:49:21 -0500
Received: from [212.187.250.66] ([212.187.250.66]:40713 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S131641AbQLJSsv>; Sun, 10 Dec 2000 13:48:51 -0500
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Graham Murray
In-Reply-To: <002901c062c9$f183d030$fdfea8c0@localnet> <20001210110213.X6567@cadcamlab.org> <20001210110213.X6567@cadcamlab.org> <m2aea42ock.fsf@barnowl.demon.co.uk>
Subject: Re: Enviromental Monitoring
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <4191.3a33c8c0.ea61e@trespassersw.daria.co.uk>
Date: Sun, 10 Dec 2000 18:17:36 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <m2aea42ock.fsf@barnowl.demon.co.uk>,
	Graham Murray <graham@barnowl.demon.co.uk> writes:
GM> Peter Samuelson <peter@cadcamlab.org> writes:
GM> 
>> [Andrew Stubbs]
>> > Has anyone implemented a /proc device or user program to interrogate
>> > the enviromental attirbutes (temp, voltage etc) that many
>> > motherboards provide via their bios's ?
>> 
>> Do a search on 'lm_sensors'.
GM> 
GM> Does this work with the latest 2.4.0-testxx kernels. It stopped
GM> working for me quite a few kernel tests ago.

lm_sensors-2.5.4 is working fine here with 2.4.0t12p7 here (MSI mobo, VIA
stuff).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
