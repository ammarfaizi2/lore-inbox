Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTLWPWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbTLWPWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:22:18 -0500
Received: from [62.42.230.12] ([62.42.230.12]:35655 "EHLO mta02.onolab.com")
	by vger.kernel.org with ESMTP id S261368AbTLWPWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:22:12 -0500
From: <xan2@ono.com>
To: linux-kernel@vger.kernel.org
Message-ID: <178ed117d672.17d672178ed1@ono.com>
Date: Tue, 23 Dec 2003 16:20:07 +0100
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: [License of kernel components]
 linux-2.x.y/Documentation/logo.GIF should be logo.PNG?
X-Accept-Language: es
X-Priority: 1 (Highest)
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe that the tux logo located at
linux-2.6.0/Documentation/logo.gif is the image that appears on the
boot of the system if framebuffer is enabled, isn't it?

In this cas, and also if it's only for documentation purpose, I think
that we could change the propietary (and I think patented) format of
this logo (gif) to anyone that were free (for example like PNG format
[that has GPL licensed]).

I don't know to who concern this change. I don't know if Larry Ewing
have to change the logo format before we can include it in the
Documentation directory of the kernel, or if we can change the format
to PNG directly (without to ask for this change to Larry).

This is not clear, and we have to comment this intention to Larry
because in this web page (http://www.isc.tamu.edu/~lewing/linux/)
there is the following text: "Permission to use and/or modify this
image is granted provided you acknowledge me lewing@isc.tamu.edu and
The GIMP if someone asks." and there is no mention about the license
of this tux logo.

For the other hand, I don't know if the kernel is capable for using
PNG images (or other free formats) rather than GIF images at boot
time. I don't know if it has this functionality. So I ask you this.


Anyway, I think that we could migrate the logo.gif in Documentation
directoy to logo.png, because with this small things is how the free
software grows and we don't depend anymore to propietary format.


Much regards,
Xan.

PS: Sorry for using this guru discusion group but I know only this way
for arriving you this question.

