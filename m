Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbULAInZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbULAInZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 03:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbULAInZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 03:43:25 -0500
Received: from CPE-203-51-26-55.nsw.bigpond.net.au ([203.51.26.55]:51959 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S261332AbULAInW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 03:43:22 -0500
Message-ID: <41AD8423.8030201@eyal.emu.id.au>
Date: Wed, 01 Dec 2004 19:43:15 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm4 - cifs.ko needs unknown symbol CIFSSMBSetPosixACL
References: <20041130095045.090de5ea.akpm@osdl.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to say that I have:

CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
CONFIG_CIFS_XATTR=y
# CONFIG_CIFS_POSIX is not set

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
