Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTDFVwZ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTDFVwZ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:52:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13200
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263122AbTDFVvo (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:51:44 -0400
Subject: Re: Debugging hard lockups (hardware?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arador <diegocg@teleline.es>
Cc: nicku@vtc.edu.hk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406222959.63add445.diegocg@teleline.es>
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
	 <1049654048.1600.11.camel@dhcp22.swansea.linux.org.uk>
	 <20030406222959.63add445.diegocg@teleline.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049663095.1602.37.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 22:04:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 21:29, Arador wrote:
> I've a similar hang; no oops; no sysrq; no NMI messages;
> But mine only happens under 2.5; since long time ago.
> The one strange thing is that it seems that it's not hanged;
> since the X pointer moves in 3-5 seconds intervals (it even
> change the shape in the window's corners).

So its not hanging, but acting like something gets burning
CPU. If you can duplicate this in non X next time it occurs
use right-alt or shift or ctrl and scrolllock get some data
on what its doing.

