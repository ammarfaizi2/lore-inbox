Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTACIVX>; Fri, 3 Jan 2003 03:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267468AbTACIVW>; Fri, 3 Jan 2003 03:21:22 -0500
Received: from [217.13.199.129] ([217.13.199.129]:22914 "EHLO
	server1.netdiscount.de") by vger.kernel.org with ESMTP
	id <S267466AbTACIVV>; Fri, 3 Jan 2003 03:21:21 -0500
Date: Fri, 3 Jan 2003 01:38:52 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Re: e1000 not detected in 2.5.53
Message-ID: <20030103003852.GA17913@core.home>
References: <3E145A31.9000305@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <3E145A31.9000305@walrond.org>
User-Agent: Mutt/1.4i
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 03:26:41PM +0000, Andrew Walrond wrote:

> Asus PR-DLS dual Xeon m/b with Intel 82544GC Gigabit controller onboard 
> (And Intel 82551QM Fast Ethernet controller incidentally)

Just a note:
my Intel Gigabit Card is in a System with an AMD 750 Chipset (Viper)
also not detected with 2.5.53 in another system (via kt133) it works.
(even if it is slow)
(as module, with acpi)
Seems to be reproducable.


Christian Leber
