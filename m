Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264260AbTCXQO3>; Mon, 24 Mar 2003 11:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbTCXQO3>; Mon, 24 Mar 2003 11:14:29 -0500
Received: from mail.idilis.net ([217.156.85.2]:32541 "EHLO mail.idilis.net")
	by vger.kernel.org with ESMTP id <S264260AbTCXQO2>;
	Mon, 24 Mar 2003 11:14:28 -0500
Message-ID: <3E7F321A.1000809@easynet.ro>
Date: Mon, 24 Mar 2003 18:28:10 +0200
From: Alex Damian <ddalex_krn@easynet.ro>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ro-RO; rv:1.0.1) Gecko/20020830
X-Accept-Language: ro, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PixelView video4linux driver
References: <Pine.LNX.4.53.0303211420170.13876@chaos>	 <1048324118.3306.3.camel@LNX.iNES.RO>  <3E7F1B6A.2000103@easynet.ro> <1048525157.25655.1.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox a scris:

>Gerd I guess. How are you handling the interlocking between the X server
>
I wrote the Gerd several times , but I got no replay... still trying

>and the tuner for registers ?
>
I'm not... currently (planning to work on , but i'll get to that next 
weekend. maybe)
For now, you have to load the module after the X starts. Otherwise it 
stucks up (deadlock
I think ). To make things even worse, I run all on dual-headed 
dual-videocard +xinerama machine.

Alex

