Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263061AbUCYAiX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbUCYAiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 19:38:22 -0500
Received: from hell.org.pl ([212.244.218.42]:1548 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263061AbUCYAfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 19:35:45 -0500
Date: Thu, 25 Mar 2004 01:35:50 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Michael Frank <mhf@linuxmail.org>
Cc: ncunningham@users.sourceforge.net,
       Dmitry Torokhov <dtor_core@ameritech.net>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040325003549.GA22940@hell.org.pl>
Mail-Followup-To: Michael Frank <mhf@linuxmail.org>,
	ncunningham@users.sourceforge.net,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <200403232352.58066.dtor_core@ameritech.net> <1080104698.3014.4.camel@calvin.wpcb.org.au> <opr5cry20s4evsfm@smtp.pacific.net.th> <20040324093231.GA15061@hell.org.pl> <opr5ddvbra4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <opr5ddvbra4evsfm@smtp.pacific.net.th>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Frank:
> Badblocks error reading beyond the end of the partition is irrelevant,
> it is a primitive bug somewhere unrelated to media condition.
> 
> Also Badblocks without disabling drive cache is _utterly_useless_.
> 
> It will not be a bare swsusp bug, I would have hit that in 20K+ cycles
> since using LZF and a thousand or so  of other 2.4 users would have
> hit it too.
> 
> Please help indentify the actual problem  by running some decent  tests.

I did my testing after hdparm -W0.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
