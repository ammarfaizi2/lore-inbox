Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTIWSQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTIWSQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 14:16:15 -0400
Received: from mail.skjellin.no ([80.239.42.67]:61670 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S263395AbTIWSQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 14:16:09 -0400
Message-ID: <3F708DE7.9060100@tomt.net>
Date: Tue, 23 Sep 2003 20:16:07 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: joe briggs <jbriggs@briggsmedia.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Spam/LKML
References: <Pine.LNX.4.58.0309231318450.11291@p500> <200309231437.43542.jbriggs@briggsmedia.com>
In-Reply-To: <200309231437.43542.jbriggs@briggsmedia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joe briggs wrote:
> I am getting hammered with them, though I use a sendmail server.  Is this a 
> manifestation or exploit of the buffer-overflow security issue out with 
> sendmail?

It's just a Microsoft virus names Gibe-F/Swen/Automat.AHB that has 
started spreading this past week or so. Same old, stupid users execute 
an attachment or whatever that scans for email-addresses and spreads 
through them.

The antivirus software on a mailserver I run has picked up 39567 of 
Gibe-F the past 24 hours.

Quoting Sophos (.com):
"W32/Gibe-F is a worm which spreads by emailing itself via its own SMTP 
engine to addresses extracted from various sources on the victim's 
drives (e.g. MBX and DBX files). The worm also spreads using the KaZaA 
peer-to-peer shared folders, via IRC channels and will copy itself to 
the Startup folder of mapped
network drives. W32/Gibe-F may also attempt to spread via usenet 
newsgroups (NNTP)."

-- 
Mvh,
André Tomt
andre@tomt.net

