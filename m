Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUFSTjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUFSTjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUFSTjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 15:39:49 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:12251 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264627AbUFSTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 15:39:42 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Vojtech Pavlik <vojtech@suse.cz>, Gabriel Lavoie <exibis@hotmail.com>
Subject: Re: Toshiba keyboard lockups
Date: Sat, 19 Jun 2004 21:48:25 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <40A162BA.90407@sun.com> <cat6f7$afh$1@sea.gmane.org> <20040619183637.GA3435@ucw.cz>
In-Reply-To: <20040619183637.GA3435@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406192148.25327.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 of June 2004 20:36, Vojtech Pavlik wrote:
> On Thu, Jun 17, 2004 at 06:37:27PM -0400, Gabriel Lavoie wrote:
> > I just reinstalled Gentoo this week and the problem appeared! With
> > kernel 2.6.5- I didn't had this problem. I now have it with 2.6.6 and
> > 2.6.7. I'm using a Toshiba Satellite A20 (Canadian version).
>
> If you could track down which change between 2.6.5 and 2.6.6 makes the
> difference for you, that'd be very helpful.

I've been having such problems since approx. 2.6.5-rc2 (anyway, the release in 
which the Prism54 driver appeared for the first time ;-)) on a Satellite 
1400-103.  However, I've found recently that it's sufficient to press the 
left SHIFT after a lockup to "release" the keyboard.  There may be some other 
specific key or a combination of keys that helps on other Toshiba models, I 
guess.

Yours,
rjw

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
