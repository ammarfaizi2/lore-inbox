Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131481AbRC3QKI>; Fri, 30 Mar 2001 11:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131497AbRC3QJs>; Fri, 30 Mar 2001 11:09:48 -0500
Received: from [194.25.18.216] ([194.25.18.216]:49418 "EHLO ntovmsw02.otto.de")
	by vger.kernel.org with ESMTP id <S131481AbRC3QJp>;
	Fri, 30 Mar 2001 11:09:45 -0500
Message-Id: <4B6025B1ABF9D211B5860008C75D57CC0271B9E7@NTOVMAIL04>
From: "Butter, Frank" <Frank.Butter@otto.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 on COMPQ Proliant
Date: Fri, 30 Mar 2001 18:08:35 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I solved it for now using the SmartStart-CD as described and I'll flash the,
ROM as soon as possible - thanks for all answers.

The only thing that isn't working yet is the FibreChannel controller.
Has anybody dealed with this internal controller and an external
COMPAQ Raid Array 4100, connected via an external FC-AL Switch?  

Thx,
Frank

> On Fri, 30 Mar 2001, Butter, Frank wrote:
> 
> > For the SMP-Problem it helped to use an option offerd at boot time:
> > "Press F9 to select different operating system". Before I used
> > "Minimum Configuration...", because Linux wasn't listed.
> 
> This is a sure sign that you need to update your firmware. 
> Download the
> latest ROMPAQ from the COMPAQ web site and reflash your 
> systems. After you
> do that run the Configuration Utility from the SmartStart CD 
> and set the
> OS type to Linux.
> 
> --
> Joel Gallun                                         joel@tux.org
> Open system and Internet consulting     http://www.tux.org/~joel
> 
