Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTLDJAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 04:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbTLDJAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 04:00:14 -0500
Received: from mail.netzentry.com ([157.22.10.66]:21512 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S261681AbTLDJAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 04:00:09 -0500
Message-ID: <3FCEF774.90904@netzentry.com>
Date: Thu, 04 Dec 2003 00:59:32 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbradney@zip.com.au
CC: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the nature of this problem. I have seen reports
it can hold out for sometimes a week.

We need patches to try on 2.6 and 2.4 bad.

Craig Bradney wrote
 >Ok folks..
 >
 >first crash here.. complete lockup. No idea how related it was to
 > the ones others are experiencing.
 >
 >Uptime at that point was 5 days 8:07.
 >
 >I was just running an emerge sync on Gentoo. I had been away
 >from the PC
 >for a few hours (it had been recompiling mozilla in that time)
 >but I had
 >woken it up for at least 20 mins before the crash.
 >
 >So now the uptime run has died.. is there anything people want me
 > to test re kernel config?
 >
 >I'm running round 80 wire IDE cables btw.
 >
 >Craig
 >
 >
 >On Thu, 2003-12-04 at 06:37, b@netzentry.com wrote:
 >> Allen Martin wrote:
 >>  >Also are people who are having problems using rounded or flat
 >>  >cables?  It's
 >>  >possible the problem could be related to DMA CRC errors.
 >>  >Switching to flat
 >>  >cables can help with that.
 >>  >
 >>  >-Allen
 >>
 >> I'm using the one that came with the board, flat 80 wire. It
 >> works under extreme stress in Windows 2000. It doesnt work
 >> in Linux.
 >>
 >>
 >> (I generated millions of interrupts from IDE and network
 >> (dual gigabit) in Windows 2000 on this very hardware for
 >> 3 days - thats why I came to the LKML, I did an empirical
 >> test that indicated Linux, and did some reading and others
 >> have had similar problems.)



