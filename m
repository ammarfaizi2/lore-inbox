Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbTLSMRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTLSMRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:17:54 -0500
Received: from smtp06.ya.com ([62.151.11.163]:50630 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S262761AbTLSMRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:17:52 -0500
Subject: Re: UHCI-HCD && mosedev on 2.6.0-test11
From: Carlos =?ISO-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Reply-To: lordeath@linuxspain.net
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031217005552.GA8753@kroah.com>
References: <1071536070.12406.5.camel@localhost>
	 <20031216174639.GD2716@kroah.com> <1071621227.11193.69.camel@localhost>
	 <20031217005552.GA8753@kroah.com>
Content-Type: text/plain
Organization: Torrejon Wireless
Message-Id: <1071835994.12921.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 13:13:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More about UHCI && mousedev.

I have compiled 2.6.0 final release, and This compilation was using
EMBEDDED(to get tristate on mousedev) and mousedev as a module.

Without inserting module mousedev uhci-hcd hangs when I remove the
device.

So mousedev module probably is ok. 

If u have any code to solve it, and u need probe it email me and I'll
compile it and probe for u.

