Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRIRAlk>; Mon, 17 Sep 2001 20:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273795AbRIRAl3>; Mon, 17 Sep 2001 20:41:29 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49415 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273794AbRIRAlS> convert rfc822-to-8bit; Mon, 17 Sep 2001 20:41:18 -0400
Date: Mon, 17 Sep 2001 20:17:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <Pine.LNX.4.33.0109171608310.1108-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0109172016200.6823-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Sep 2001, Linus Torvalds wrote:

> 
> Ok, the big thing here is continued merging, this time with Andrea.
> 
> I still don't like some of the VM changes, but integrating Andrea's VM
> changes results in (a) better performance and (b) much cleaner inactive
> page handling in particular. Besides, for the 2.4.x tree, the big priority
> is stability, we can re-address my other concerns during 2.5.x.

Andrea, 

Could you please make a resume of your VM changes ? 


Its hard to keep up with VM changes this way. 

