Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbTJMTuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 15:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTJMTuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 15:50:32 -0400
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:45383 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S261920AbTJMTua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 15:50:30 -0400
Message-ID: <3F8B01FE.3050505@planet.nl>
Date: Mon, 13 Oct 2003 21:50:22 +0200
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sebastian Piecha <spi@gmxpro.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [INFO] gcc versions used to compile a kernel
References: <3F8ACFA0.10239.10815846@localhost>
In-Reply-To: <3F8ACFA0.10239.10815846@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Sebastian,

This is very interesting as I've been compiling kernels with GCC 3.2.0 
and higher since the first beta I compiled. I've never had the issues 
that you are describing with kernel 2.5.70 and higher and 2.6.0 test 1> 
6. This most likly is a machine related problem. Which Linux distibution 
are you using and how uptodate is the rest of the machine.

Best regards,

Stef

Sebastian Piecha wrote:

>The last days I had a lot of trouble getting different kernel 
>versions to run. Enclosed is a short report of the experience I made.
>
>First I tried to compile all kernels with gcc 3.3.1.
>
>2.4.20 I even couldn't compile.
>2.4.22-ac4 compiled well but oopsed immediately after booting.
>2.6.0-test4 and test5 compiled well but didn't boot and froze with a 
>blank screen.
>2.6.0-test6 compiled well but froze after starting /sbin/init.
>
>Then I used gcc 2.95.3 for compiling 2.4.20, 2.4.22-ac4 and 2.6.0-
>test7 and all kernels booted smoothly.
>
>It's seems that at least in my configuration gcc 3.3.1 is doing a bad 
>job.
>
>Mit freundlichen Gruessen/Best regards,
>Sebastian Piecha
>
>EMail: spi@gmxpro.de
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


