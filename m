Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264169AbTDWRhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbTDWRhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:37:37 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:62666 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S264169AbTDWRhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:37:00 -0400
Message-ID: <3EA6D210.3060403@suwalski.net>
Date: Wed, 23 Apr 2003 13:49:04 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030331
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423172120.GA12497@citd.de> <3EA6947D.9080106@suwalski.net> <1527920000.1051118798@flay>
In-Reply-To: <1527920000.1051118798@flay>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> But I fail to understand how the distro can magically set a sensible 
> default, and yet we're unable to do so inside the kernel ? Setting it
> to something like 10 (or other very quiet setting) would seem reasonable.
> Then at least the poor user would have a clue what the problem was.

It does not. The entire point of the original problem was that the 
settings were not saved. It is not important that the initial is zero.

It is important that when I shutdown and then come back, the sound 
settings are as I left them. And this is a distribution issue. More 
specifically, my problem; my alsa-utils package.

--Pat

