Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbVJ1WVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbVJ1WVh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 18:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVJ1WVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 18:21:37 -0400
Received: from sender-02.it.helsinki.fi ([128.214.205.137]:37564 "EHLO
	sender-02.it.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750715AbVJ1WVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 18:21:36 -0400
Date: Sat, 29 Oct 2005 01:21:33 +0300 (EEST)
From: Janne M O Heikkinen <jmoheikk@cc.helsinki.fi>
X-X-Sender: jmoheikk@rock.it.helsinki.fi
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64: 2.6.14 with NUMA panics at boot
In-Reply-To: <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
Message-ID: <Pine.OSF.4.61.0510290118530.417152@rock.it.helsinki.fi>
References: <Pine.OSF.4.61.0510282218310.411472@rock.it.helsinki.fi>
 <p73vezhtkpy.fsf@verdi.suse.de> <Pine.OSF.4.61.0510290058420.417368@rock.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Oct 2005, Janne M O Heikkinen wrote:

There was one line missing for that post, should have been:

...
BIOS-e820: 0000000100000000 - 0000000140000000 (usable)
Kernel direct mapping tables upto ffff810140000000 @ 8000 - e0000
SRAT: PXM 0 -> APIC 0 -> CPU 0 -> Node 0
...
