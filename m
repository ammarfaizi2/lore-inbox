Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbTCVFcC>; Sat, 22 Mar 2003 00:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbTCVFcC>; Sat, 22 Mar 2003 00:32:02 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:9994 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262036AbTCVFcB>; Sat, 22 Mar 2003 00:32:01 -0500
Date: Sat, 22 Mar 2003 06:42:58 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: Alon <alon@gamebox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine timeouts
Message-ID: <20030322054258.GA5694@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20030321232047.D7D771800D2@smtp-2.hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321232047.D7D771800D2@smtp-2.hotpop.com>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alon <alon@gamebox.net>
Date: Sat, Mar 22, 2003 at 12:20:09AM +0100
> Hi,
> 
> I am suffering from what a quick Google search has shown
> to be the infamous netdev watchdog lock in Rhine NICs,a
> although in a somwhat different way from most cases I've
> seen reported. Instead of failing under heavy load, my card
> (in fact, an onboard chip in the ECS L7VTA-L motherboard)
> completely refuses to make a connection under 2.4.x kernels.
> I tried all releases between 2.4.18 and current 2.4.21-pre5
> to no avail. The driver provided by VIA at their site
> fared no better.
> 
This driver has been worked on recently in the 2.5.x kernels - can you
try 2.5.65?

HTH,
Jurriaan
-- 
Look, I'm about to buy me a double barreled sawed off shotgun and show
Linus what I think about backspace and delete not working.
	some anonymous .signature
GNU/Linux 2.5.65-mm3 4276 bogomips load av: 0.31 0.08 0.05
