Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbUCNDfm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 22:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbUCNDfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 22:35:42 -0500
Received: from main.gmane.org ([80.91.224.249]:64182 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263267AbUCNDfl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 22:35:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joshua Kwan <joshk@triplehelix.org>
Subject: drivers/usb/class/usblp.c: usblp0: on fire
Date: Sat, 13 Mar 2004 19:35:53 -0800
Message-ID: <pan.2004.03.14.03.35.52.138779@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-68-126-222-152.dsl.pltn13.pacbell.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

$SUBJECT pretty much scared the hell out of me...

I noticed something fishy going on with USB in 2.6.4, maybe before. I am
having lots of trouble printing using usblp. Once, I got the
aforementioned message, and sometimes I get 

usb 2-1: control timeout on ep0in

Many times repeated. The bottom line is that I cannot print and I'm not
sure whether it's something I forgot to configure after reinstalling this
box, or something with the kernel. Could I be enlightented?

-- 
Joshua Kwan


