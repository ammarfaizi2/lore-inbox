Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTIHWV0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbTIHWV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:21:26 -0400
Received: from gprs145-40.eurotel.cz ([160.218.145.40]:35973 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261764AbTIHWVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:21:25 -0400
Date: Tue, 9 Sep 2003 00:21:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: Sven =?iso-8859-1?Q?K=F6hler?= <skoehler@upb.de>
Cc: Paul Clements <Paul.Clements@SteelEye.com>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [NBD] patch and documentation
Message-ID: <20030908222111.GG429@elf.ucw.cz>
References: <3F5CB554.5040507@upb.de> <20030908193838.GA435@elf.ucw.cz> <3F5CE0E5.A5A08A91@SteelEye.com> <3F5CE3E6.8070201@upb.de> <3F5CF045.DDDE475C@SteelEye.com> <3F5CFF0B.6080609@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5CFF0B.6080609@upb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Another idea would be to be abled to specify the max_sectors while 
> connecting an NBD. That would add an optional paramter to the nbd-client 
> command line. (like it is possible for the blocksize)

I do not see why it should be configurable...

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
