Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUBCPpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUBCPpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:45:35 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:2308 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S266010AbUBCPpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:45:34 -0500
Message-ID: <401FC21C.8070802@zvala.cz>
Date: Tue, 03 Feb 2004 16:45:32 +0100
From: Tomas Zvala <tomas@zvala.cz>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos> <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos>
In-Reply-To: <Pine.LNX.4.53.0402031018170.31411@chaos>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok,
Im sorry for misinformation ... I better just keep on reading not 
writing :).
But anyway. The thing that mislead me is that I would expect to get 
"already mounted" message if  I tried to mount the drive to the same 
mountpoint again.(at least i get it if i try to do it with read-only 
mounted xfs. i cant try it with iso9660 on cdr).

Tomas Zvala

Richard B. Johnson wrote:

>On Tue, 3 Feb 2004, Tomas Zvala wrote:
>
>  
>
>That's not what he said and, I assure you that if he unmounted
>it there would not be any buffers to flush. Execute `man umount`.
>
>  
>
