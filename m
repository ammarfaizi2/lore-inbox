Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUJ3P1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUJ3P1R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUJ3P0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:26:24 -0400
Received: from mid-1.inet.it ([213.92.5.18]:46021 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S261229AbUJ3OpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:45:24 -0400
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Date: Sat, 30 Oct 2004 16:44:33 +0200
User-Agent: KMail/1.7.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <200410272012.44361.dtor_core@ameritech.net> <20041029205505.GB30638@kroah.com>
In-Reply-To: <20041029205505.GB30638@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200410301644.33997.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 22:55, venerdì 29 ottobre 2004, Greg KH ha scritto:


>
> So we can change things, little things like this can help everyone out,
> even if I'm going to get a ton of nvidia user hate mail directed to me
> after the next kernel comes out...
>
> Remember, binary kernel modules are a leach on our community.

I'm one of the users biten by this change, and I can undestand your reason; 
anyway from my standpoint the situation is that a change that has no 
technical motivation (at least to my knowledge) is going to remove an 
interface that until now was available, and prevents me to use my card with 
new kernels; this is too similar to some closed souce companies behaviour. No 
big deal, I can live with that, but if this is the right way to handle that 
interface, why this is enforced only now and not from the very first time? 
Granted that you have all the rights to do that, may I ask if this is not in 
contrast with is stated in this post? 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.2/0369.html

I understand all your motivation,and I agree with most of them, but I'm asking 
if this is the right way to handle this GPL issue...


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
