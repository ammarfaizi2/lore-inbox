Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUA0GJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 01:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUA0GJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 01:09:51 -0500
Received: from main.gmane.org ([80.91.224.249]:47763 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262714AbUA0GJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 01:09:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: yoann <informatique-nospam@mistur.org>
Subject: Re: atkbd.c: Unknown key released
Date: Tue, 27 Jan 2004 07:09:56 +0100
Message-ID: <bv4vbb$ru3$1@sea.gmane.org>
References: <200401261834.54450@sandersweb.net> <20040127052507.GF18411@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: fr, fr-fr, en, en-gb
In-Reply-To: <20040127052507.GF18411@charite.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I keep getting the following in my syslog whenever I startx:
> 
> Which hardware?
> 
>>Jan 26 13:43:56 debian kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
>>Jan 26 13:43:56 debian kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>Jan 26 13:43:57 debian kernel: atkbd.c: Unknown key released (translated set 2, code 0x7a on isa0060/serio0).
>>Jan 26 13:43:57 debian kernel: atkbd.c: This is an XFree86 bug. It shouldn't access hardware directly.
>>
>>I don't get the error with the 2.4.24 kernel.
> 
> Same here.

same here with a 2.6.2-rc1-mm2
Xfree86 Version: 4.2.1-15 (debian sid)

Yoann


