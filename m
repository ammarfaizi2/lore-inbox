Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRIMMUs>; Thu, 13 Sep 2001 08:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270229AbRIMMU3>; Thu, 13 Sep 2001 08:20:29 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24448 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270174AbRIMMUO> convert rfc822-to-8bit; Thu, 13 Sep 2001 08:20:14 -0400
Date: Thu, 13 Sep 2001 08:20:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: csaradap <csaradap@mihy.mot.com>
cc: "linux-india-help@lists.sourceforge.net" 
	<linux-india-help@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: junk values at ppplogin
In-Reply-To: <3BA0A0D0.19E0E76F@mihy.mot.com>
Message-ID: <Pine.LNX.3.95.1010913081828.3271A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, csaradap wrote:

> I am configuring a ppp link over null modem. When I am trying to login I
> get junk values like
> 
> ~ÿ}#À!}!}!} }4}"}&} } } } }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } }
> }%}&*}]ÝH}'}"}(}"ÉÂ~~ÿ}#À!}!}!} }4}"}&} } } } }%}&*}]ÝH}'}"}(}"ÉÂ~
> 
> Can any body tell me what is the problem???
> 
> thanx

Well, yes.  You have ppp running!  Your script must log-in FIRST,
then it must start ppp, first on the server you logged in on, then
next on your machine.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


