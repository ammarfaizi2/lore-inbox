Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbULQHX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbULQHX2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262760AbULQHX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:23:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:55516 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262759AbULQHXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:23:25 -0500
Date: Fri, 17 Dec 2004 08:23:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: debugfs in the namespace
In-Reply-To: <20041216221843.GA10172@kroah.com>
Message-ID: <Pine.LNX.4.61.0412170822050.9865@yvahk01.tjqt.qr>
References: <20041216110002.3e0ddf52@lembas.zaitcev.lan> <20041216190835.GE5654@kroah.com>
 <41C20356.4010900@sun.com> <20041216221843.GA10172@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So, let's pick a place and be done with it.
>
>I like /dbg (3 characters total to get to, which is shorter than /debug
>which takes at least 4, 3 chars and a tab).  Pete likes /debug.  Jan
>Engelhardt want to hide the thing from people at /.debugfs.
>
>Hm, what about /.debug ?  That's a compromise that I can live with (even
>less key strokes to get to...)

Anything is acceptable at least if my dot is there :)

>So, /.debug sound acceptable?

No objections.

>

Jan Engelhardt
-- 
ENOSPC
