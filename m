Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbTIUVly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 17:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbTIUVly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 17:41:54 -0400
Received: from smtp4.hy.skanova.net ([195.67.199.133]:48834 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S262566AbTIUVlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 17:41:53 -0400
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broken synaptics mouse..
References: <200309212317.40703.gallir@uib.es>
From: Peter Osterlund <petero2@telia.com>
Date: 21 Sep 2003 23:41:50 +0200
In-Reply-To: <200309212317.40703.gallir@uib.es>
Message-ID: <m2y8whq0o1.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> writes:

> >> linux-petero/drivers/input/mouse/synaptics.c | 68 +++++++++++------- 
> >> linux-petero/drivers/input/mousedev.c | 100 +++++++++++++++++++-------- 
> >> linux-petero/include/linux/input.h | 3 3 files changed, 118 
> >> insertions(+), 53 deletions(-)
> >
> > Yes, this now looks very nice. Applied.
> 
> Which patches are required to test it? (it can't be applied to -bk8).

You need the three other patches I've posted earlier today. You can
find the patches here:

http://w1.894.telia.com/~u89404340/patches/touchpad/2.6.0-test5-bk8/v1/

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
