Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265992AbUAQEWa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 23:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265996AbUAQEW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 23:22:29 -0500
Received: from pool-64-223-239-211.port.east.verizon.net ([64.223.239.211]:37599
	"EHLO evilbint.mylan") by vger.kernel.org with ESMTP
	id S265992AbUAQEW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 23:22:27 -0500
Date: Fri, 16 Jan 2004 23:22:26 -0500
From: Greg Fitzgerald <gregf@bigtimegeeks.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
Message-ID: <20040117042226.GA5445@evilbint>
References: <20040115225948.6b994a48.akpm@osdl.org> <20040117013115.GA5524@evilbint> <200401162305.26269.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401162305.26269.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry,

	psmouse.proto=exps worked perfect. Thanks very much.

--Greg


On (01/16/04 23:05), Dmitry Torokhov wrote:
> To: Greg Fitzgerald <gregf@bigtimegeeks.com>, linux-kernel@vger.kernel.org
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> Date: Fri, 16 Jan 2004 23:05:26 -0500
> Subject: Re: 2.6.1-mm4
> 
> On Friday 16 January 2004 08:31 pm, Greg Fitzgerald wrote:
> > Hi,
> >
> > 	Just gave 2.6.1-mm4 a try hoping to fix my NFS problems. NFS seems
> > to be working better but now my mouse is not working properly. I have
> > psmouse.psmouse_proto=exps in my grub.conf.
> >
> 
> Please change it to psmouse.proto=exps
> 
> -- 
> Dmitry
