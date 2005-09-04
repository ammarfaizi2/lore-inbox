Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVIDIqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVIDIqb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 04:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVIDIqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 04:46:31 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:17084 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751220AbVIDIqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 04:46:30 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Genesys USB 2.0 enclosures
Date: Sun, 4 Sep 2005 10:46:01 +0200
User-Agent: KMail/1.8.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       USB Storage list <usb-storage@lists.one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0509032151040.5675-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0509032151040.5675-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041046.01652.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 03:53, Alan Stern wrote:
>
> This one certainly goes into the Bizarro file.
>
> Just out of curiosity -- when you use the powered hub, does the drive work
> even if you remove that delay completely?

I haven't tested that. I will, next time I need the drive, which will probably 
be in about a week. 

I just wanted to make my backup, and finally managed to do that. I don't get 
it either what's really wrong with these chips - but it was one of the 
recommendations i found on the linux-usb device list pages. And it seems to 
work.

If now only I can get the firewire part of one of them working without 
serialize_io, then I can use that too.

Jan

-- 
A billion here, a billion there -- pretty soon it adds up to real money.
		-- Sen. Everett Dirksen, on the U.S. defense budget
