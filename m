Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTFFXr2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTFFXr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:47:28 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:38537 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262373AbTFFXq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:46:59 -0400
Message-Id: <200306070000.h5700OsG002995@ginger.cmf.nrl.navy.mil>
To: Werner Almesberger <wa@almesberger.net>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Fri, 06 Jun 2003 12:26:16 -0300."
             <20030606122616.B3232@almesberger.net> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 06 Jun 2003 19:58:35 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030606122616.B3232@almesberger.net>,Werner Almesberger writes:
>Removing an ATM device while there are open VCCs isn't a lot
>more useful than removing a telephone while there is still a
>call in progress :-)

ever hang up in the middle of a call?  ever want to hang up
in the middle of a phone call?
