Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbTHUHmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbTHUHmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:42:19 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:14747 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262502AbTHUHmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:42:15 -0400
Subject: Re: 48-bit Drives Incorrectly reporting 255 Heads?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jw schultz <jw@pegasys.ws>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030821053824.GA21451@pegasys.ws>
References: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
	 <20030821053824.GA21451@pegasys.ws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061451704.3044.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 21 Aug 2003 08:41:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-21 at 06:38, jw schultz wrote:
> A 240 head drive would have to have multiple heads per
> surface or the stack of disks on the spindle would be about
> 5 feet tall.

PC class hardware is all about layers of compatibility hacks.
IDE "geometry" became fictional before 540Mb disks. Sectors/track
etc is all made up too nowdays.

