Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268581AbUJKAGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268581AbUJKAGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268582AbUJKAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 20:06:46 -0400
Received: from hacksaw.org ([66.92.70.107]:21918 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S268581AbUJKAGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 20:06:43 -0400
Message-Id: <200410110006.i9B06aF9019868@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: "J.A. Magallon" <jamagallon@able.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ? 
In-reply-to: Your message of "Sun, 10 Oct 2004 23:25:46 -0000."
             <1097450746l.5993l.0l@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Oct 2004 20:06:36 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't think it is needed. There is no problem (i am thinking on rootles
>nodes and PXE and so on...) on building a simple initrd with /dev/console,
>/dev/null

I'm looking for no initrd. I'm not a fan of them. It seems like having to use 
an electric drill to start your car.

I like the idea that someone could accidentally scribble all over /dev, and on 
reboot the system would just rebuild it. It makes /dev less of a vulnerability.


-- 
Sleepy, Dopey, Sneezy, Bashful, Grumpy, Happy, Doc
Just in case you'd forgotten...
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


