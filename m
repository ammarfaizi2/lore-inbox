Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbTIHWRt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbTIHWRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:17:48 -0400
Received: from mailgate.uni-paderborn.de ([131.234.22.32]:64650 "EHLO
	mailgate.uni-paderborn.de") by vger.kernel.org with ESMTP
	id S263702AbTIHWRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:17:47 -0400
Message-ID: <3F5CFF0B.6080609@upb.de>
Date: Tue, 09 Sep 2003 00:13:31 +0200
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: de, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com>
In-Reply-To: <3F5CF045.DDDE475C@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please see http://imap.upb.de for details
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-15.7, required 4,
	IN_REP_TO -3.30, REFERENCES -6.60, USER_AGENT_MOZILLA_UA -5.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another idea would be to be abled to specify the max_sectors while 
connecting an NBD. That would add an optional paramter to the nbd-client 
command line. (like it is possible for the blocksize)

