Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTIWNwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 09:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTIWNwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 09:52:09 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:35532 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263380AbTIWNwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 09:52:08 -0400
Message-Id: <200309231352.h8NDpxkT024738@ginger.cmf.nrl.navy.mil>
To: John Levon <levon@movementarian.org>
cc: davem@redhat.com, Remi Colinet <remi.colinet@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Compile fix for 2.6.0-test5-mm4 in net/atm/proc.c 
In-Reply-To: Message from John Levon <levon@movementarian.org> 
   of "Tue, 23 Sep 2003 13:57:02 BST." <20030923125702.GB92228@compsoc.man.ac.uk> 
Date: Tue, 23 Sep 2003 09:52:00 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030923125702.GB92228@compsoc.man.ac.uk>,John Levon writes:
>What are your plans with mine and Mitchell's stuff that removes all this
>ops crap altogether ?

working on testing it.  sorry but i havent had much time with the
end of the gov't fiscal year coming up.  in the meantime this short
little patch should solve things in the meantime.
