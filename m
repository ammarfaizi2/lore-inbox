Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbTLKKPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 05:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbTLKKPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 05:15:14 -0500
Received: from main.gmane.org ([80.91.224.249]:50316 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264598AbTLKKPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 05:15:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Thu, 11 Dec 2003 11:15:07 +0100
Message-ID: <yw1xk753hd90.fsf@kth.se>
References: <1070963757.869.86.camel@nomade> <Pine.LNX.4.44.0312091358210.21314-100000@gaia.cela.pl>
 <20031209183001.GA9496@kroah.com> <yw1xvfop257d.fsf@kth.se>
 <1071039765.1790.94.camel@nomade>
 <20031210210614.625ccfcc.witukind@nsbm.kicks-ass.org>
 <1071134837.1789.123.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:AFOwseDiF4qnSnyVZD6AAE/hhhY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel <xavier.bestel@free.fr> writes:

> Le mer 10/12/2003 à 21:06, Witukind a écrit :
>> On Wed, 10 Dec 2003 08:02:46 +0100
>> Xavier Bestel <xavier.bestel@free.fr> wrote:
>> > Come on ... the stock kernel from your distribution will do the
>> > modprobe for you when you access the floppy, I'm sure you're skilled
>> > enough to configure your own kernel to do the same.
>> > And if you don't want to recompile, just chmod +s modprobe - on your
>> > small machine which needs to save 60k, I bet you're the only user. Or
>> > use sudo.
>> > 
>> > 	Xav
>> 
>> I was expecting this kind of reply. Like "if you have an older hardware you
>> can fuck off".
>
> Wow ... how can you understand this in my text ? Because I'm guessing he
> is the only user on his machine ? This has nothing to do with small
> machines, but with system configuration: load on-demand may be done
> without devfs.

It certainly can be done without devfs.  I was objecting to the udev
way of thinking that all drivers are always loaded.  If you want to
use udev and on-demand loading, you need to do some tweaking.

> Well, I wish do apologize to Måns if he thought I was ridiculing his
> hardware. Just take out the last sentence with "modprobe" if it bothers
> you.

Well, my hardware is as good as any.

-- 
Måns Rullgård
mru@kth.se

