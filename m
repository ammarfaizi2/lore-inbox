Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317971AbSHaUB7>; Sat, 31 Aug 2002 16:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317980AbSHaUB7>; Sat, 31 Aug 2002 16:01:59 -0400
Received: from mta11n.bluewin.ch ([195.186.1.211]:37557 "EHLO
	mta11n.bluewin.ch") by vger.kernel.org with ESMTP
	id <S317971AbSHaUB6>; Sat, 31 Aug 2002 16:01:58 -0400
Message-ID: <3D7120A7.9080106@linkvest.com>
Date: Sat, 31 Aug 2002 22:01:43 +0200
From: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexis de Bernis <alexis@bernis.org>, linux-kernel@vger.kernel.org
Subject: Re: SMB browser
References: <3D709AB7.705@linkvest.com> <20020831103928.B140@alexis.itd.umich.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
 >
 >	Isn't that what does Sharity ? Ok, it's not open-source, but if
 >you never heard of that program give it a try, it may help you to define
 >your implementation...

Yes, sharity does exactly what I'd like to do!
But it's not free...

I remarked that there is no kernel module loaded, just a daemon and an
[rpciod] kernel thread that started just after the daemon. I see that in 
the "ps -ef" list.
I think that means that the daemon communicate with the rpciod (what is
this beast exactly?) to provide filesystem informations.
How do we do that? What are the principles behind that? What are the
needed calls?

Thanks
-jec



