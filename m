Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSKMVRo>; Wed, 13 Nov 2002 16:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSKMVRn>; Wed, 13 Nov 2002 16:17:43 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:10918 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262838AbSKMVRG>;
	Wed, 13 Nov 2002 16:17:06 -0500
Date: Wed, 13 Nov 2002 21:22:26 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47-ac2 initializes mcheck twice...
Message-ID: <20021113212226.GA19904@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
	kernel list <linux-kernel@vger.kernel.org>
References: <20021113211008.GA7542@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021113211008.GA7542@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 10:10:09PM +0100, Pavel Machek wrote:
 > ...and it will not compile with mcheck disabled. This is (maybe
 > right?) fix.

Patch is correct, and went to Alan earlier this afternoon.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
