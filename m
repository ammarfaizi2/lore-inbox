Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSAYXwr>; Fri, 25 Jan 2002 18:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288804AbSAYXwi>; Fri, 25 Jan 2002 18:52:38 -0500
Received: from lilly.ping.de ([62.72.90.2]:46604 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S288557AbSAYXwZ>;
	Fri, 25 Jan 2002 18:52:25 -0500
Date: 26 Jan 2002 00:51:06 +0100
Message-ID: <20020125235106.GA771@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: linux-kernel@vger.kernel.org
Subject: apm: busy: Unable to enter requested state
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem which I noticed recently. I have a DFI AK76SN + Athlon
1.2GHz. I use apm to get the system into suspend mode. This worked a
long time ago. But now all I get is:

apm: setting state busy
apm: busy: Unable to enter requested state
apm: setting state busy
apm: busy: Unable to enter requested state
apm: received normal resume notify

and then the cpu does not cool down (I guess it is not shut down like it
was before). Previously this worked fine and the cpu temperature at
resume was "room temperature" (20°C). But now it is almost always ~48°C.

Some changes which I remember:

- update bios (I reinstalled the previous bios but it did not help)
- updated kernel version (I actually don't remember which version I was
  using but I think 2.4.12 worked fine but does not work now)

Do I have to tweak the bios or is this a kernel issue or is there
something wrong with the bios?

What infos can I provide else? I tried 5 different bios versions,
changed most bios settings regarding power management, tried different
kernel versions, ... So I am running out of ideas ...

Regards,

   Jogi

-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
