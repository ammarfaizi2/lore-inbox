Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUDCT6r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 14:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUDCT6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 14:58:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:6299 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261907AbUDCT6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 14:58:45 -0500
X-Authenticated: #294883
Message-ID: <406F1771.9080109@gmx.de>
Date: Sat, 03 Apr 2004 21:58:41 +0200
From: Hans-Georg Esser <h.g.esser@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Jackson <brian@brianandsara.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 and 2.4.21, Firewire, 160 GB Harddisk, 134 GB barrier
References: <406EC833.4080909@gmx.de> <200404031053.41975.brian@brianandsara.net>
In-Reply-To: <200404031053.41975.brian@brianandsara.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Jackson wrote:
>>>My drive (Western Digital WD1600BB-32DWA0) works well when directly
>>>connected to the IDE controller, but doesn't like using an external
>>>firewire connection ("Pyro 1394 Drive Kit" of Adstech.com). The firewire
[...]
> The more likely scenario is that the bridge chip in said box doesn't support 
> the larger drive and is the limiting factor.
> 
> --Brian Jackson

Ouch, yes. I tried it with an Apple Mac (with OS X), same problem. Sorry,
I completely didn't suspect the hardware to cause the problem, the firewire
drive kit is only four months old...

Thanks,

Hans-Georg


-- 
Hans-Georg Eßer  -  http://privat.hgesser.com  -  Tel. 089 99248380
GPG Fingerprint: F319 10C0 76E2 DAAD DDFA  F017 4CAD BB99 A4A9 9E53
