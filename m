Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUGZSYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUGZSYZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 14:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUGZSYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 14:24:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.185]:30430 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266290AbUGZQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:31:25 -0400
From: Emmeran Seehuber <rototor@rototor.de>
To: Frederik Himpe <fhimpe@pandora.be>
Subject: Re: 2.6.7-ck5: System hangs under constant load
Date: Mon, 26 Jul 2004 18:31:22 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200407252227.05580.rototor@rototor.de> <200407252321.22781.rototor@rototor.de> <pan.2004.07.26.12.46.33.38548@pandora.be>
In-Reply-To: <pan.2004.07.26.12.46.33.38548@pandora.be>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407261831.22891.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Thanks, it seems especially the network chip (Realtek 8139) is similar,
> and both have a graphics chip based on radeon (although this one is an
> integrated thing).

Hmm, I don't really think that the Realtek causes the problem. It's not 
connected to a network cable, so it shouldn't be used. It's AFAIK also very 
common, so problems with this network adapter should be detectable and 
reproducable by other people very fast.

>
> I have put more detailed information (dmesg, lsmod,
> config, lspci -v) on http://users.telenet.be/fhimpe/kernelbug/ . Maybe you
> could also make it available somewhere?

Ok, my files are here:
http://www.rototor.de/sonstiges/

cu,
  Emmy
