Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265356AbRGBRms>; Mon, 2 Jul 2001 13:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265360AbRGBRmj>; Mon, 2 Jul 2001 13:42:39 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:28177 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S265356AbRGBRmT>;
	Mon, 2 Jul 2001 13:42:19 -0400
Message-ID: <20010702194212.A400@win.tue.nl>
Date: Mon, 2 Jul 2001 19:42:12 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, kernel@ddx.a2000.nu
Cc: linux-kernel@vger.kernel.org, enforcer@ddx.a2000.nu (Enforcer)
Subject: Re: Strange errors in /var/log/messages
In-Reply-To: <Pine.LNX.4.30.0107021800410.5490-100000@ddx.a2000.nu> <E15H6N5-000663-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <E15H6N5-000663-00@the-village.bc.nu>; from Alan Cox on Mon, Jul 02, 2001 at 05:16:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2001 at 05:16:23PM +0100, Alan Cox wrote:

> > I'm running RedHat 7.0 with all official RH patches applied. The kernel I
> > currently run fow a few days is 2.2.19-7.0.8
> > I run the pre-compiled kernel of RH. Suddenly I the following messages:
> > 
> > Jul  2 15:12:16 gateway SERVER[1240]: Dispatch_input: bad request line
> > 'BBXXXXXXXXXXXXXXXXXX%.176u%3
> > 00$nsecurity.%301$n%302$n%.192u%303$n\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\220\22

> These are for an application.  Not sure which or why 

See CERT Advisory CA-2000-22
	http://www.infowar.com/iwftp/cert/advisories/CA-2000-22.html

  "A popular replacement software package to the BSD lpd printing service
   called LPRng contains at least one software defect, known as a "format string
   vulnerability," which may allow remote users to execute arbitrary code on
   vulnerable systems."
