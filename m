Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275103AbTHGFo0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275105AbTHGFo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:44:26 -0400
Received: from ALille-209-1-12-194.w81-249.abo.wanadoo.fr ([81.249.41.194]:5649
	"EHLO lenhof.homelinux.net") by vger.kernel.org with ESMTP
	id S275103AbTHGFoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:44:25 -0400
Subject: Re: [2.6] system is very slow during disk access
From: Jean-Yves LENHOF <jean-yves@lenhof.eu.org>
To: linux-kernel@vger.kernel.org
Cc: fsdeveloper@yahoo.de
Content-Type: text/plain
Message-Id: <1060235110.618.5.camel@mydebian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 07 Aug 2003 07:45:10 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have massive problems with linux-2.6.0-test2. 
> When some process writes something to disk, it's very hard 
> to go on working with the system. 
> 
> 
> Some test-szenario: 
> $ dd if=/dev/zero of=./test.file 
> 
> 
> While dd is running, xmms skips playing every now and then 
> and the mouse is near to be unusable. The Mouse-cursor 
> behaves some kind of very lazy and some times it jumps 
> from one point on the display to another. 
> When I stop disk-access, it works again quite fine. 
> 
> 
> Would be cool, if you could give me some point to start 
> for tracking this down. 

Maybe this is this one again...

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/2552.html

Regards,

Jean-Yves

