Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291324AbSAaVTF>; Thu, 31 Jan 2002 16:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291320AbSAaVSy>; Thu, 31 Jan 2002 16:18:54 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:52557 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S291319AbSAaVSn>; Thu, 31 Jan 2002 16:18:43 -0500
Date: Thu, 31 Jan 2002 22:18:36 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: James Simmons <jsimmons@transvirtual.com>
cc: <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] amiga input api drivers
In-Reply-To: <Pine.LNX.4.10.10201310712130.20956-100000@www.transvirtual.com>
Message-Id: <Pine.LNX.4.33.0201312216460.10027-100000@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002, James Simmons wrote:

> +	scancode = scancode >> 1;	/* lowest bit is release bit */
> +	down = scancode & 1;

Shouldn't that be the other way 'round?

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: DC26 EB8D 1F35 4F44 2934  7583 DBB6 F98D 9198 3292
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

