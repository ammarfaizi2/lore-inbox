Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161289AbWGNSu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161289AbWGNSu5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 14:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161290AbWGNSu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 14:50:57 -0400
Received: from iona.labri.fr ([147.210.8.143]:44727 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1161289AbWGNSu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 14:50:56 -0400
Message-ID: <44B7E78F.6070309@ens-lyon.fr>
Date: Fri, 14 Jul 2006 20:50:55 +0200
From: =?ISO-8859-1?Q?C=E9dric_Augonnet?= <Cedric.Augonnet@ens-lyon.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm2
References: <20060713224800.6cbdbf5d.akpm@osdl.org>	<44B7DB25.4050905@ens-lyon.fr> <20060714111804.39af438a.akpm@osdl.org>
In-Reply-To: <20060714111804.39af438a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :

>On Fri, 14 Jul 2006 19:57:57 +0200
>Cédric Augonnet <Cedric.Augonnet@ens-lyon.fr> wrote:
>
>  
>
>>I got this bug and this oops when booting with my USB hard-drive plugged 
>>(it was not in mm1).  I also have the same problem when hot-plugging it. 
>>And there is no oops at all without this USB hard-drive. Here is what 
>>appears in my dmesg, and I join my .config.
>>    
>>
>
>yup, sorry. 
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm2/hot-fixes/drivers-base-check-errors-fix.patch
>should fix it.
>  
>
It indeed solves the problem, I do not see any trouble any more !
Thanks you once again. Next time i'll wait 4 mn before sending my bug 
report :)

Best regards,
Cédric
