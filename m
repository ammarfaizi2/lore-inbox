Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263581AbUECD1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbUECD1M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 23:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263582AbUECD1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 23:27:12 -0400
Received: from opersys.com ([64.40.108.71]:37902 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263581AbUECD1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 23:27:09 -0400
Message-ID: <4095BD6A.5000803@opersys.com>
Date: Sun, 02 May 2004 23:32:58 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hand with radeon 9000 / AGP / DRI
References: <408B7DA4.7010101@opersys.com> <408E833C.6030808@techsource.com>
In-Reply-To: <408E833C.6030808@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Timothy Miller wrote:
> Which driver are you using for OpenGL?  The x11 (mesa) driver, or ATI's 
> driver?  ATI's driver doesn't play nice with radeonfb.

The X11 one. I used to use ATI's, but it didn't really give me any
advantage over X11 (At least not that I could see.) So it went the way
of "rpm -e".

> Also, telling radeonfb what resolution you want on the boot command line 
> is broken if the res you request and the res reported by EDID disagree.

I'm not giving it any res at all as boot parm.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

