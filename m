Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVIHTbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVIHTbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVIHTbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:31:52 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:8125 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964950AbVIHTbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:31:51 -0400
Subject: Re: Brand-new notebook useless with Linux...
From: Lee Revell <rlrevell@joe-job.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200509081522_MC3-1-A986-1B52@compuserve.com>
References: <200509081522_MC3-1-A986-1B52@compuserve.com>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 15:31:44 -0400
Message-Id: <1126207905.12697.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 15:19 -0400, Chuck Ebbert wrote:
> In-Reply-To: <1125805091.14032.69.camel@mindpipe>
> 
> On Sat, 03 Sep 2005 at 23:38:10 -0400, Lee Revell wrote:
> 
> > On Sat, 2005-09-03 at 18:58 -0400, Chuck Ebbert wrote:
> > > I just bought a new notebook.
> > 
> > I'd return it if I were you.
> 
>  What fun is that?  I have learned that HP/Compaq is hostile to Linux,
> for one thing, which was interesting (my system is a Compaq Presario
> V2312US.)
> 
>  Can you help me find out why my codec is unknown?  I gave up trying to
> figure out how to get the codec ID and hacked the source to print it:
> 
> 
> atiixp: codec 0 not available for modem
> atiixp: no codec available
> ALSA device list:
>   #0 ATI IXP rev 2 with 0x43585430 at 0xd0003400, irq 177
> 
> 
> So it's a Conexant codec with ID 0x30 on an atiixp.  OSS has some support
> for this codec, apparently.

Wait, that sounds like the modem, not the AC97 audio codec.

You might be able to get the modem to work with the (proprietary)
slmodem software modem, or something.  I wouldn't count on it though.

Does your sound work?

Lee

