Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbVIPJle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbVIPJle (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161146AbVIPJld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:41:33 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:37924 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161145AbVIPJld convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:41:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bXjx/s8q1vl6RR8iHk+XlLALIMGh7falN7ipN+TwJSUmXbzXpqB8zHpNpuaT7YLJyr1Nr9taXV1Jt3DkAhFaVkXE2WcrqJBcBYCMUIlklO8kQyWN6movO36fdL19cEgLnljtW0eAOUyAQHQmwtUIvnP/sGnEej1AXwJfGnBxbg0=
Message-ID: <5c43128e050916024110467f02@mail.gmail.com>
Date: Fri, 16 Sep 2005 11:41:29 +0200
From: Wim Vinckier <wimpunk@gmail.com>
Reply-To: wimpunk@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Trouble hotplugging on embedded system
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

I'm trying to get usb hotplugging working on a embedded system but it
doesn't (seem to) work.  As far as i understand all the documents I've
read, /sbin/hotplug (depending on /proc/sys/kernel/hotplug) should be
called whenever plugging in a device.  I guess I've forgot to enable
something in my kernel configuration but I can't find what went wrong.
 I've tried 2.6.8 and 2.6.12 with busybox 1.01.

anyone any suggestion?

wim.
