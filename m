Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277595AbRJLIwB>; Fri, 12 Oct 2001 04:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277601AbRJLIvw>; Fri, 12 Oct 2001 04:51:52 -0400
Received: from zamok.crans.org ([138.231.136.6]:4549 "HELO zamok.crans.org")
	by vger.kernel.org with SMTP id <S277598AbRJLIvn>;
	Fri, 12 Oct 2001 04:51:43 -0400
From: Vincent Bernat <bernat@free.fr>
To: "Jeremy M. Dolan" <jmd@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Joystick problems with 2.4.12, Configure.help patch
In-Reply-To: <20011011160640.A218@foozle.turbogeek.org>
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
In-Reply-To: <20011011160640.A218@foozle.turbogeek.org> ("Jeremy M. Dolan"'s
 message of "Thu, 11 Oct 2001 16:06:40 -0500")
Organization: Kabale Inc
Date: Fri, 12 Oct 2001 10:53:07 +0200
Message-ID: <m3d73tfde4.fsf@neo.loria>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Artificial
 Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO La nuit ayant déjà recouvert d'encre ce jour du jeudi 11 octobre
2001, vers 23:06, Jeremy Dolan disait:

> I have a 2 axis 6 button analog (ns558) gamepad. With 2.4.7,
> everything is fine, as long as I pass js=gamepad, it detects the 2
> axis and 6 buttons.

> With 2.4.12, with js=gamepad, the kernel message SAYS it detects 2
> axis and 6 buttons, however when I use it (for example, with the jstest
> program), the two axis and buttons 4/5 don't register. The first four
> (0-3) buttons are fine. If I reboot to 2.4.7 they all are fine, so it
> is software.

I have similar problem when I have switched from 2.4.9 to 2.4.10 : I
have a two buttons, two axis joystick and the axis don't work.
-- 
I WILL NOT SELL SCHOOL PROPERTY
I WILL NOT SELL SCHOOL PROPERTY
I WILL NOT SELL SCHOOL PROPERTY
-+- Bart Simpson on chalkboard in episode 7F10
