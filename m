Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVINFQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVINFQo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVINFQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:16:44 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:2708
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S965013AbVINFQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:16:43 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Keith Owens <kaos@ocs.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7255.1126583985@kao2.melbourne.sgi.com>
References: <7255.1126583985@kao2.melbourne.sgi.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 23:16:32 -0600
Message-Id: <1126674993.5681.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 13:59 +1000, Keith Owens wrote:
> On Mon, 12 Sep 2005 21:54:29 -0600, 
> Alejandro Bonilla Beeche <abonilla@linuxwireless.org> wrote:
> >If I do make menuconfig, it still says 2.6.13 instead of 2.6.14-rc1.
> 
> rsync.kernel.org has not been updated from the master yet.  Give it an
> hour and try again.

Hi,

	Is Linus git tree the one used for the rc's and the final release?

I keep updating and it still says 2.6.13 instead of 2.6.14-rc1. I don't
really care if that is cosmetic, is fine, I just want to make sure that
I'm up to date?

Again, this is what I do:

cd linux-2.6
git pull
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git checkout

? Anyone

.Alejandro

PS: Thanks for kicking in HDAPS into this tree.

