Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbTJNN0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 09:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTJNN0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 09:26:24 -0400
Received: from [213.229.38.66] ([213.229.38.66]:41165 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S262418AbTJNN0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 09:26:19 -0400
Message-ID: <3F8BF859.2050806@winischhofer.net>
Date: Tue, 14 Oct 2003 15:21:29 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
References: <E1A9P22-0000D2-UX@rhn.tartu-labor>
In-Reply-To: <E1A9P22-0000D2-UX@rhn.tartu-labor>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> TW> This is a framebuffer driver and like all fbdev-related stuff it is 
> TW> properly maintained in the fbdev-tree, waiting to merged into mainline.
> 
> Since James seems busy, someone should step up, split these changes into
> patches, test (or let people test) them separately and submit to kernel.
> Of course in coordination with James, he knows hat should be stable and
> what not. I would take this myself by have not enough time.

That sounds a little like "Linus is busy, let someone else quickly hop 
in"... :)

The fbdev tree is quite well tested AFAIK, and I am sure James will 
respond soon. He can't be too busy, as he was working on the tree yesterday.

Thomas


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



