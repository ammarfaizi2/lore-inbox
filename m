Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTLBLka (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 06:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLBLka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 06:40:30 -0500
Received: from main.gmane.org ([80.91.224.249]:28397 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261956AbTLBLk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 06:40:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Thomas Weidner" <3.14159@gmx.net>
Subject: Re: [RFC/PATCH 1/3] Input: resume support for i8042 (atkbd & psmouse)
Date: Tue, 2 Dec 2003 11:40:25 +0100
Message-ID: <bqhtn6$r1f$1@sea.gmane.org>
References: <200312010215.58533.dtor_core@ameritech.net>
X-Complaints-To: usenet@sea.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.50.4927.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dmitry Torokhov" <dtor_core@ameritech.net> schrieb im Newsbeitrag
news:200312010215.58533.dtor_core@ameritech.net...
> Hi,
>
> Here is an attempt to implement resume for i8042 using serio_reconnect
> facility that can be found in -mm kernels. It also depends on bunch of
> other changes in input subsystem all of which can be found here:
> http://www.geocities.com/dt_or/input
>
> They should apply cleanly to -test11.
>

I haven't looked at the patches,but after i applied all to the kernel, my
ps/2 keyboard works again correctly.
it was broken in -test11,that i need to unplug it and then plug it again in
to make it work,after booting.





