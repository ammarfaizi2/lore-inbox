Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262383AbTCMO4I>; Thu, 13 Mar 2003 09:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbTCMO4I>; Thu, 13 Mar 2003 09:56:08 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:15248 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262383AbTCMOzQ>; Thu, 13 Mar 2003 09:55:16 -0500
Date: Thu, 13 Mar 2003 16:05:44 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Stevenson <james@stev.org>, pd dd <parviz_kernel@yahoo.com>,
       "M. Soltysiak" <msoltysiak@hotmail.com>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: re: Linux BUG: Memory Leak
Message-ID: <20030313150544.GC5488@louise.pinerecords.com>
References: <20030313091315.14044.qmail@web20504.mail.yahoo.com> <01f801c2e96c$980b4390$0cfea8c0@ezdsp.com> <1047570333.25944.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047570333.25944.42.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> There were problems with the XFree 4.3 DRM if you mixed it with
> certain other ingredients like rmap. I don't know what Slackware
> ships but that may be the problem.

Slackware 8.1 shipped with XFree 4.2.0 and linux-2.4.18 vanilla.

Slackware 9.0 will probably ship with XFree 4.3.0 and linux-2.4.20
with Andrew Morton's ext3 patches.

As far as I can tell, DRM has worked nicely with both 8.1 and 9.0-rc[12].

-- 
Tomas Szepe <szepe@pinerecords.com>
