Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268279AbUIKR5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268279AbUIKR5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIKR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:57:39 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:64595 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S268240AbUIKR50 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:57:26 -0400
Subject: Re: radeon-pre-2
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e473391040911101331a584ec@mail.gmail.com>
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
	 <9e473391040911101331a584ec@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sat, 11 Sep 2004 13:57:10 -0400
Message-Id: <1094925430.22136.9.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-11 at 13:13 -0400, Jon Smirl wrote:
> Coprocessor 3D mode is deeply pipelined
> 2D mode is immediate

Have you looked at the radeon X driver acceleration code in the last
couple of years?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
