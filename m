Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290536AbSBLR2a>; Tue, 12 Feb 2002 12:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290807AbSBLR2V>; Tue, 12 Feb 2002 12:28:21 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:1667 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S290536AbSBLR2J>; Tue, 12 Feb 2002 12:28:09 -0500
Message-ID: <3C695266.251BA11B@nortelnetworks.com>
Date: Tue, 12 Feb 2002 12:35:34 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.3.96.1020212113237.5657B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> I like making it a module because it's obvious that modules_install is
> needed. I see zero added utility from having it part of the kernel or
> nothing, it's useful even to people booting from ROM, small /boot
> partitions, etc.

Not everyone uses modules.  There are a substantial number of people that avoid
modules if possible.  Ideally, it should be possible to make the config options
built in, modular, or not present at all.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
