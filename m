Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSLJO0S>; Tue, 10 Dec 2002 09:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSLJO0S>; Tue, 10 Dec 2002 09:26:18 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:17939 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261689AbSLJO0S>; Tue, 10 Dec 2002 09:26:18 -0500
Message-Id: <200212101427.gBAERda00976@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Sipos Ferenc <sferi@mail.tvnet.hu>, linux-kernel@vger.kernel.org
Subject: Re: kernel or distro bug?
Date: Tue, 10 Dec 2002 17:17:21 -0200
X-Mailer: KMail [version 1.3.2]
References: <1039295986.1486.4.camel@zeus.city.tvnet.hu>
In-Reply-To: <1039295986.1486.4.camel@zeus.city.tvnet.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 December 2002 19:19, Sipos Ferenc wrote:
> Hi!
>
> I'm using rh8 as a default distro. I've compiled 2.4.19 stock kernel,
> everything works fine. With the same config options, I've compiled
> 2.4.20, but when I reboot the machine with the new kernel, the boot
> process stops at starting iptables line, and nothing happens. When I
> remove the iptables daemon with chkconfig, system boots fine, and
> when I start the daemon by hand, it works. Neither 2.4.19 nore 2.5.50
> has a problem with the iptables daemon during startup. Has anybody
> met the above situation?

Where exactly it stops? Can you run it under strace or something?
--
vda
