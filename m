Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTBQQiT>; Mon, 17 Feb 2003 11:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTBQQiT>; Mon, 17 Feb 2003 11:38:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61706 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267153AbTBQQiT>;
	Mon, 17 Feb 2003 11:38:19 -0500
Message-ID: <3E511238.7080001@pobox.com>
Date: Mon, 17 Feb 2003 11:47:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: ghugh Song <ghugh@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Trouble w/ e1000 v4.4.19 for Intel gigabit 82545EM on-board chip.
References: <20030217142025.A5BB51AFB4@bellini.mit.edu>
In-Reply-To: <20030217142025.A5BB51AFB4@bellini.mit.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ghugh Song wrote:
> Under SuSE-8.1-CDROM supplied 2.4.19-UP with e1000 v4.3.15 module, this 
> ethernet worked on a E7505 based Supermicro X5DA8 Dual Xeon motherboard
> with the Intel 82545EM chip on board with no special kernel option
> inserted.  The RJ45 is hooked to 100Mb/s speed CISCO switching hub.
> 
> Now, e1000 v4.4.19 custom-built 2.4.21-pre4ac4 with SMP enabled does not work.
> e1000 is detected.  It appeared properly in ifconfig with its own 
> HWaddr.  But it does not work.


Does stock 2.4.20 work?
Does 2.4.20 + 2.4.21-pre4 pre-patch work?

