Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbUKRKJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUKRKJP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbUKRKJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:09:07 -0500
Received: from main.gmane.org ([80.91.229.2]:64956 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262693AbUKRKHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:07:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: hotplug_path no longer exported
Date: Thu, 18 Nov 2004 02:06:54 -0800
Message-ID: <419C743E.8090309@triplehelix.org>
References: <20041117203139.7c9f5e95.colin@colino.net> <20041117214824.GA1291@kroah.com> <20041117231253.1ec92e6f.colin@colino.net> <20041117222340.GA4494@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-237-170.dsl.pltn13.pacbell.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041112)
X-Accept-Language: en-us, en
In-Reply-To: <20041117222340.GA4494@kroah.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greg KH wrote:
| On Wed, Nov 17, 2004 at 11:12:53PM +0100, Colin Leroy wrote:
|
|>Dunno. This driver has a reputation of being the worse wlan driver for
|>prism2 chipsets out there, but it's the only one supporting USB devices.
|
|
| Hm, I've heard that rumor before too.  If only someone would get me such
| a usb device, maybe that problem could be fixed :)

Actually, orinoco_usb in current Orinoco CVS has support for some of
these devices and I'm using one right now. The driver works pretty well
but I'm not sure whether orinoco_usb supports many prism2_usb devices
the same way orinoco_cs supports many prism2_cs devices.

So, if I sent you my wireless device it wouldn't be much help :)

- --
Joshua Kwan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQZx0PaOILr94RG8mAQJHixAAyM6MhoS7z6IAT4tbU1i/VjBEI9WwJ7HC
LCLnGSKqghy0HUZ/W/sbDqYX3or+LFweunCmKDPC9b62/uOwxSjMzi+6LT7Zy0eU
InPF4NJaMRWgdgOBCjE8/ZrpZooREcCAyeNDJjLjFzSEcG//7A6yqJumqb3A3XX+
O1+cM5SDsIZsnCjup/R0GTMaGXBAALickM3oIiTYLk3ByOQTkrb0dbvxUlos1K9F
oAZbUP07uaFZdEr60g768whpGoiN+QEOpPsE9uiON06UlPouPfAyRq5X72XOwEhJ
Ey/D7y1OkiFECCN0Y+n+bgr+LZjpORbVocs9H4tKAqs8KS7ypx0EdB2UuGL8mLWB
wsAu402RpUaA6X2MNm6ZrX96T1KumABMrVTh506UEVUccSxvTXq3KvZ04TrSppdL
7uvx4RtV26fR3wUqM7zaGAqmlUCrmK1SilGEDhsIR5uUyyL7nzEifsN0qnuDDngS
Mo5pedurJpsKQhDvdfuemqWecGqQ/RYwGrK8U321bXeishjuaFR2Riq7/LseANzh
hFiHdI3lOJeNirPBUIgP89blIWgjTRwZ2segKSWV49+ls/qlmSURRuEgrYMcJKQR
oasMqV0Ba5h4pdICRp25/iFzflvzRg7rvZae1k6lqNeyxgVqJPPpwFDAPWguhSGF
hHd2DEkvJdk=
=aGiw
-----END PGP SIGNATURE-----

