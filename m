Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271121AbTGPVjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271122AbTGPVjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:39:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30924
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271121AbTGPVjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:39:48 -0400
Subject: Re: Linux 2.6.0-test1-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Kristensen <michael@wtf.dk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716201339.GA618@sokrates>
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com>
	 <20030716201339.GA618@sokrates>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058392329.7677.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 22:52:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 21:13, Michael Kristensen wrote:
> Apropos emu10k1. Why is OSS deprecated? I have tried a little to get
> ALSA working, but it doesn't seem to work. Hint?

ALSA has a lot more functionality than OSS and the API is better in many
ways. The ALSA drivers dont have so much use and exposure so they will
need time to shake down, but it should be worth it in the end.

> By the way, Alan Cox. I think you forgot to increment the ac1 to ac2
> somewhere.

So I did 8)

