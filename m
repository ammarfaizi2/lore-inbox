Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268907AbUHUIlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268907AbUHUIlN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268906AbUHUIlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:41:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11755 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268907AbUHUIlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:41:07 -0400
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Josan Kadett <corporate@superonline.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200408211127.45076.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200408211127.45076.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Message-Id: <1093077667.854.69.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 04:41:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 04:27, Denis Vlasenko wrote:
> On Saturday 21 August 2004 12:18, Josan Kadett wrote:
> > That is not much of an intelligible idea. A way to hack the kernel could be
> > found as I still presume. "Turn off checksums" but not by re-writing the
> > whole tcp code in the kernel. Isn't that possible ? Linux is an operating
> > system of infinite possibilities, right ? But only if you know how to hack
> > it...
> 
> Of course you can hack the kernel to do it.
> 
> However, by replacing that box with Linux device you
> get one more Linux box and you will be capable of
> doing whole slew of useful things, like traffic filtering, shaping,
> accounting, Ethernet bridging, etc etc etc, if/when you will need it.
> You can easily debug problems with tools like tcpdump and ethereal.
> I simply cannot list everything Linux can do, I don't plan to write
> a novel here ;]
> 
> I bet current 'crazy box' has nothing even vaguely resembling
> these capabilities. Heck, it cannot do standard TCP properly.
> So there is little reason to waste your time trying to work around it.

He already stated that he was dealing with a very expensive, very broken
piece of hardware, and he needs a way to work around it.  Many of us
have been in this situation, I will not name names ;-).  Telling him to
just replace it is not helpful.

Lee

