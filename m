Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311247AbSCSOKo>; Tue, 19 Mar 2002 09:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311252AbSCSOKe>; Tue, 19 Mar 2002 09:10:34 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:22700 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S311247AbSCSOKQ>; Tue, 19 Mar 2002 09:10:16 -0500
Date: Tue, 19 Mar 2002 15:05:38 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alternative linux configurator prototype v0.2
Message-ID: <20020319150538.B1350@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C9396F5.7319AB27@linux-m68k.org> <3C94948E.777B5BAF@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neat.
I would appreciate somewhat more readability, though. It's not very
simple to figure out in which state an option is (Y/N/M) if it's not focused.
Maybe put the selected variant before the option name:
+ Networking options
  + Packet socket
  | <M> Netlink device emulation
  | <N> Network packet filtering ...

Besides, i think your selection of qt as gui platform is not making you
many friends, though greatly speeded up the development.

-alex
  
On Sun, Mar 17, 2002 at 02:05:18PM +0100, Roman Zippel wrote:
> Hi,
> 
> I wrote:
> 
> > At http://www.xs4all.nl/~zippel/lc.tar.gz you can find a prototype for a
> > new linux configurator (see the included README for build/use
> > information). It has reached a point, where it's becoming usable and I
> > need some feedback on how/if to continue.
> 
> There is a new version at http://www.xs4all.nl/~zippel/lc/lc-0.2.tar.gz,
> this version also works with qt2.x.
> So far I hadn't very much feedback. What's up? Is everyone suddenly
> completely happy with cml2? Now is your chance to evaluate the
> alternatives or does this require too much work before you can start
> flaming?
> 
> bye, Roman
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
