Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbTEEVjc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 17:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbTEEVjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 17:39:31 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:33249 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261375AbTEEVjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 17:39:31 -0400
Date: Mon, 5 May 2003 14:38:18 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030505123818.GE10323@zaurus.ucw.cz>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com> <20030419184120.GH669@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419184120.GH669@gallifrey>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   Besides the problem that most drive manufacturers now seem to use
> cheese as the data storage surface, I think there are some other
> problems:
> 
>   1) I don't trust drive firmware.

I created crc loop method just for this.
Make it md5 loop method and you would
be able to trust that...
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

