Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTDPITR (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 04:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbTDPITR 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 04:19:17 -0400
Received: from [62.231.65.103] ([62.231.65.103]:14600 "HELO ultrapopular.com")
	by vger.kernel.org with SMTP id S264264AbTDPITQ 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 04:19:16 -0400
Message-ID: <3E9D150E.6000601@easynet.ro>
Date: Wed, 16 Apr 2003 11:32:14 +0300
From: Alexandru Damian <ddalex_krn@easynet.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ro-RO; rv:1.2.1) Gecko/20030225
X-Accept-Language: ro, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PixelView video4linux driver
References: <Pine.LNX.4.53.0303211420170.13876@chaos> <1048324118.3306.3.camel@LNX.iNES.RO> <3E7F1B6A.2000103@easynet.ro> <1048525157.25655.1.camel@irongate.swansea.linux.org.uk> <3E7F321A.1000809@easynet.ro> <87ptog628m.fsf@bytesex.org> <3E9C196F.5060205@easynet.ro>
In-Reply-To: <3E9C196F.5060205@easynet.ro>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Alex Damian wrote:

> For now, you have to load the module after the X starts. Otherwise
> it stucks up (deadlock I think ).
>    


I switched to Linux RedHat 9, XFree 4.3.0, running with vanilla 2.4.20 
and my module.
I didn't change anything into my code, but the problem with X freezing 
while loading
with my module (called clgdtv ) insmoded into the kernel dissapeared.

Maybe someone can help me with a hint about what's going on, and how should
I handle interlocking between X and clgdtv.

>> Sounds like it needs some more work ...
>
It sure does

>>  Gerd
>
Alex


