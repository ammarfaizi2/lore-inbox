Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTGAUj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 16:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTGAUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 16:39:56 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:646 "EHLO
	mwinf0604.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263665AbTGAUjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 16:39:55 -0400
Message-ID: <3F01F55F.7060703@wanadoo.fr>
Date: Tue, 01 Jul 2003 22:55:59 +0200
From: =?ISO-8859-1?Q?R=E9mi_Colinet?= <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73 / Speedtouch USB modem / configuration problem
References: <3EFF3D04.9060208@wanadoo.fr> <200306300948.55455.baldrick@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:

>>I'm trying to use the Alcatel Speedtouch USB modem with 2.5.73. I'm
>>facing a configuration problem and couldn't find a solution using Google.
>>    
>>
>
>Hi Remi, it looks like you are trying to use the user space driver (the one
>from http://speedtouch.sourceforge.net/), but have the kernel driver loaded
>(the speedtch module; see http://www.linux-usb.org/SpeedTouch/).  These
>two drivers do not play nicely together.
>
Hi Duncan,

I wasn't aware about this point.

I'm going to try with the kernel driver.

Thanks very much for your help :-)
Rémi


