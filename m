Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271707AbRIGLEr>; Fri, 7 Sep 2001 07:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271711AbRIGLEi>; Fri, 7 Sep 2001 07:04:38 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:36877 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271707AbRIGLEV>; Fri, 7 Sep 2001 07:04:21 -0400
Date: Fri, 7 Sep 2001 13:04:38 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Mike Jagdis <jaggy@purplet.demon.co.uk>
Cc: Wietse Venema <wietse@porcupine.org>, linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010907130438.C13826@emma1.emma.line.org>
Mail-Followup-To: Mike Jagdis <jaggy@purplet.demon.co.uk>,
	Wietse Venema <wietse@porcupine.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010906173948.502BFBC06C@spike.porcupine.org> <3B98A1C0.6010200@purplet.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3B98A1C0.6010200@purplet.demon.co.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Sep 2001, Mike Jagdis wrote:

> If I understand correctly you want to get a full list of addresses
> and netmasks that have been assigned to interfaces?
> 
>   Use netlink. I'm sure someone else has said that but I haven't
> read the entire thread, just scanned for the almost certainly
> required example attachment (netlink is only straight forward once
> you have an example :-( ). Attached is something that simply
> asks for the current addresses (and "aliases"). It should be fairly
> easy to use.

Whoa. 215 lines for just getting addresses.

No personal offense, but what do people think this is if not bloat?
