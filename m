Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271448AbUJVQyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271448AbUJVQyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271430AbUJVQwC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:52:02 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:52457 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S271432AbUJVQuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:50:54 -0400
Message-ID: <41793A63.30908@nortelnetworks.com>
Date: Fri, 22 Oct 2004 10:50:43 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Greg Buchholz <linux@sleepingsquirrel.org>, linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <82D5E38355314D46AF3015FF55F6955802F83515@CORPMAIL3> <4177FF47.5040005@techsource.com> <20041021213600.GB675@sleepingsquirrel.org> <41783ADB.8030802@techsource.com> <20041021234053.GC675@sleepingsquirrel.org> <417939F1.8090601@techsource.com>
In-Reply-To: <417939F1.8090601@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> Anyhow, the reason for that long discussion is because I see chip design 
> and software programming as generally incompatible mindsets.  Sure, one 
> can certainly help you to learn the other, but many methodologies that 
> apply to one would be horrible to apply to the other.

Hmm...I've got a buddy doing a Master's in codesign, where you literally design 
the chip and the software to run on it at the same time, so you can simulate 
them both at the same time and optimise which bits you do in hardware and which 
in software.

Seems to me that chip design and software programming (at least for low-level 
high-performance stuff) are tightly intertwined.

Of course there's the other side of things where you write in prolog or lisp and 
are totally abstracted from the hardware--but I don't see too many people 
writing e.g. graphics drivers in those languages.

Chris
