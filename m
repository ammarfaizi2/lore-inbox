Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTLDGWU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 01:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTLDGWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 01:22:20 -0500
Received: from opersys.com ([64.40.108.71]:36370 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262655AbTLDGWT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 01:22:19 -0500
Message-ID: <3FCED34B.5050309@opersys.com>
Date: Thu, 04 Dec 2003 01:25:15 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Kendall Bennett <KendallB@scitechsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.58.0312031533530.2055@home.osdl.org> <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312031614000.2055@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Linus,

Linus Torvalds wrote:
> Similarly, historically there was a much stronger argument for things like
> AFS and some of the binary drivers (long forgotten now) for having been
> developed totally independently of Linux: they literally were developed
> before Linux even existed, by people who had zero knowledge of Linux. That
> tends to strengthen the argument that they clearly aren't derived.
> 
> In contrast, these days it would be hard to argue that a new driver or
> filesystem was developed without any thought of Linux. I think the NVidia
> people can probably reasonably honestly say that the code they ported had
> _no_ Linux origin. But quite frankly, I'd be less inclined to believe that
> for some other projects out there..

Since the last time this was mentioned, I have been thinking that this
argument can really be read as an invitation to do just what's being
described: first implement a driver/module in a non-Linux OS (this may even
imply requiring that whoever works on the driver/module have NO Linux
experience whatsoever; yes there will always be candidates for this) and then
have this driver/module ported to Linux by Linux-aware developers.

Sure, one could argue about "intent", but that's going to be really
difficult, especially if the right-hand doesn't know what the left-hand
is doing. IOW, can't this position be abused as much as, if not more
than, publishing an "approved" set of characteristics for non-GPL modules?

Just thinking aloud,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

