Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVC0VWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVC0VWe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVC0VWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:22:34 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:22584 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261587AbVC0VW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:22:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=l1Ww9MCYem+7InQ2Lzlds1qRKiwMTOe2ArgHu9tGCdxlm3LiMfSVJ6eBAXF00lupgIsZlPRhDSYcS1KGZV/y5u055/oKAibk3gz2qxghbj0TpQNzPvD8QkFFQKZpjgSEVSxM1jImadc96nUDuK8IfwGiBNRWxRO26BQcSavvQqE=
Date: Sun, 27 Mar 2005 23:22:21 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Aaron Gyes <floam@sh.nu>
Cc: bunk@stusta.de, gilbertd@treblig.org, mrmacman_g4@mac.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-Id: <20050327232221.5748a973.diegocg@gmail.com>
In-Reply-To: <1111951014.9831.4.camel@localhost>
References: <1111886147.1495.3.camel@localhost>
	<490243b66dc7c3f592df7a7d0769dcb7@mac.com>
	<1111913399.6297.28.camel@laptopd505.fenrus.org>
	<16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
	<20050327180417.GD3815@gallifrey>
	<20050327183522.GM4285@stusta.de>
	<1111951014.9831.4.camel@localhost>
X-Mailer: Sylpheed version 1.9.6+svn (GTK+ 2.6.2; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 27 Mar 2005 11:16:54 -0800,
Aaron Gyes <floam@sh.nu> escribió:

> company that made the device? Should NVIDIA be forced to give up their
> secrets to all their competitors because some over zealous developers
> say so? Should the end-users of the current drivers be forced to lose

Is not just about zealotism, propietary drivers have to deal with locking, multiple
architectures and so on, and often they're not very good at that.

Note that this is not a problem only with linux, Windows is suffering the same
every day. Here: http://blogs.msdn.com/oldnewthing/archive/2004/03/05/84469.aspx
is a good example of how *scary* can be. This is what happens in a OS where a 
certification process is needed. I don't want to know what are they doing in linux,
where such certification doesn't exist.....
