Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTKBVp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 16:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTKBVp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 16:45:27 -0500
Received: from mail02.agrinet.ch ([81.221.250.51]:52754 "EHLO
	mail02.agrinet.ch") by vger.kernel.org with ESMTP id S261850AbTKBVpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 16:45:23 -0500
From: Erwin Telser <erwin.telser@pop.agri.ch>
To: linux-kernel@vger.kernel.org
Subject: Responsiveness of 2.6.0-Test9
Date: Sun, 2 Nov 2003 23:45:08 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311022345.08192.erwin.telser@pop.agri.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are there things to observe when switching from 2.4 to 2.6, if I want the same 
responsiveness? I'm asking because I' ve made the following observation. (I 
always had the feeling, 2.4 seems to faster, but this is the first time it' s 
very obvious)

I' ve connected two monitors on a Matrox G550. One runs with DRI the other one 
doesn't (not possible with the current driver). The Monitor with DRI I'm 
using as a TV Set, watching movies with xawtv. (With a bttv 878 tuner card).

Now with the 2.4.22 kernel (preemptible patch aplied) I can play the little 
game kbounce on the other monitor, without to notice any slowdown, no matter, 
whether xawtv is running or not.

But with the 2.6 Kernel (compiled with preemptible option) the bouncing balls 
slow down considerably, as soon as I move the mouse.

I know the whole thing is a little foolish. But anyway, are there some tricks 
to get the same responsiveness?

Erwin



