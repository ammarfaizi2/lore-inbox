Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275312AbTHGMgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275314AbTHGMgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:36:24 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:52866 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275312AbTHGMgP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:36:15 -0400
Subject: Re: Is it possible to add this feature.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Patrick McLean <pmclean@linuxfreak.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F31F558.5050104@linuxfreak.ca>
References: <3F3049D0.6040804@hsdm.com>
	 <20030806003054.GN6541@kurtwerks.com>
	 <20030806005348.GB15764@matchmail.com>
	 <pan.2003.08.06.07.47.15.831811@sourcefrog.net>
	 <3F31F558.5050104@linuxfreak.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060259548.3123.43.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 13:32:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 07:44, Patrick McLean wrote:
> I am going to be working on this feature with a friend starting in
> September as a term project (we are both undergrads in computer
> science), and a way to get into kernel hacking :) Send me a mail if
> you want more info, or if you want us to keep you up to date on
> our progress.
> 
> We will also be loking for ways to specify the limits in a fairly 
> simple, but scalable way, and we will be happy for any suggestions.

Google for two things - firstly Rik van Riel's bits of work (I think it
was Rik anyway) on a fair share scheduler, also "beancounter" which was
a patch long ago that started to attack the limits issues)

