Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263831AbTIIAQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 20:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTIIAQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 20:16:58 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:14530 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S263831AbTIIAQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 20:16:58 -0400
Message-ID: <3F5D1AF4.5060001@upb.de>
Date: Tue, 09 Sep 2003 02:12:36 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Paul Clements <Paul.Clements@SteelEye.com>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com> <3F5CFF0B.6080609@upb.de> <20030908222111.GG429@elf.ucw.cz> <3F5D0186.4030001@upb.de> <20030908232824.GH429@elf.ucw.cz>
In-Reply-To: <20030908232824.GH429@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-25.4, required 4,
	IN_REP_TO -3.30, QUOTED_EMAIL_TEXT -3.20, REFERENCES -6.60,
	REPLY_WITH_QUOTES -6.50, USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe that 1MB is good, and good enough for close future. If that
> ever proves to be problem, we can add handshake at that point. But I
> do not believe it will be neccessary.

Well, we shouldn't discuss the max_sectors problem (or what ever we 
should call it) too much. I must seem as a bullhead to you.

