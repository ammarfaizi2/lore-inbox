Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263480AbTIBEGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 00:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbTIBEFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 00:05:42 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:11126 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263444AbTIBEF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 00:05:26 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Chris Peterson" <chris@potamus.org>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: laptop touchpad on linux-2.6.0-test4
Date: Mon, 1 Sep 2003 23:05:20 -0500
User-Agent: KMail/1.5.3
References: <005f01c37105$56460370$323be90c@bananacabana>
In-Reply-To: <005f01c37105$56460370$323be90c@bananacabana>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309012305.20802.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 September 2003 10:50 pm, Chris Peterson wrote:
> I upgraded a working Redhat 9 installation (linux-2.4.20) to
> linux-2.6.0-test4. I can boot and start X and Gnome successfully.
> Unfortunately, my laptop's touchpad and mouse "joystick" do not work. My
> laptop is a Dell Latitude C400. I have not tried an external mouse because
> my laptop does not have an external mouse port.
>
> Using Google, I've found some LKML threads about problems with the
> Synaptics touchpad driver and the evdev kernel module, but the threads end
> before a verified solution ("it works now. thanks!") is posted. Is there a
> known fix for this touchpad problem?
>

Please see:

http://w1.894.telia.com/~u89404340/touchpad/index.html for a new XFree 
driver and bunch for extra kernel patches needed to make track stick
work

http://geocities.com/dt_or/gpm/gpm.html for updated version of GPM

Dmitry
