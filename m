Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbTEMOyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTEMOyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:54:44 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:10510 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261350AbTEMOyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:54:43 -0400
Message-ID: <3EC10A2F.70109@inet6.fr>
Date: Tue, 13 May 2003 17:07:27 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: root@chaos.analogic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: What exactly does "supports Linux" mean?
References: <20030513151630.75ad4028.skraw@ithnet.com> <1052830415.432.2.camel@dhcp22.swansea.linux.org.uk> <Pine.LNX.4.53.0305131016180.238@chaos>
In-Reply-To: <Pine.LNX.4.53.0305131016180.238@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>If you really want it to work, try `insmod -f modulename.o`.[...]
>

Of course, don't do this unless you can live with the following :

1/ nobody will support you in this configuration.
2/ you have zero guarantee that your hardware will be supported in the 
future (what will happen when you upgrade to a new kernel with different 
interfaces and the vendor marketing folks decide that Linux support 
isn't a good thing anymore ?).


