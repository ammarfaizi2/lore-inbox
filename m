Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTBJSyq>; Mon, 10 Feb 2003 13:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTBJSyq>; Mon, 10 Feb 2003 13:54:46 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:8210 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262420AbTBJSyp>; Mon, 10 Feb 2003 13:54:45 -0500
Date: Mon, 10 Feb 2003 14:04:30 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200302101904.h1AJ4US05141@devserv.devel.redhat.com>
To: Kevin Fenzi <kevin-linux-kernel@scrye.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x end of tape handling error
In-Reply-To: <mailman.1044901620.21591.linux-kernel2news@redhat.com>
References: <mailman.1044901620.21591.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have had reported from a client that they are having problems with
> backups that span more than one tape. Instead of getting an EOT error
> or EOM, they are getting an I/O error wich requires the driver to be
> unloaded and reloaded before the tape will work again. 
> 
> http://www.linuxtapecert.org/ Says that the redhat 2.4.9-34 kernel is
> the last one that had proper EOT handling. Indeed, if they use the
> 2.4.9-34 kernel, the tape works properly. Thats not a very good
> solution however. 

You neglected to mention what kind of tape it is. There are
several types of tapes, served by a jigsaw puzzle of various
drivers.

> Is this fixed in the latest 2.4.21-pres? How about in 2.5.x?

Why don't you try and verify it, then let us know? You may
be the only guy in the world mad enough to use a tape with 2.5.x.
Please share your valuable expirience.

-- Pete
