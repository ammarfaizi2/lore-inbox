Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289339AbSA1Tho>; Mon, 28 Jan 2002 14:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289343AbSA1The>; Mon, 28 Jan 2002 14:37:34 -0500
Received: from peabody.ximian.com ([141.154.95.10]:18442 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP
	id <S289339AbSA1ThP>; Mon, 28 Jan 2002 14:37:15 -0500
Subject: Ethernet data corruption?
From: Kevin Breit <mrproper@ximian.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.23.19.37 (Preview Release)
Date: 28 Jan 2002 14:40:03 -0600
Message-Id: <1012250404.5401.6.camel@kbreit.lan>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	The other night, my friend was sending me a video over the internet. 
We tried http, ftp, and other protocols, using different download
applications.  It seemed to be corrupt, the same way, everytime.  It
wouldn't work, and had a different md5sum than the "good" version on my
friend's computer.  Eventually we got it working.
	The same issue came up again today.  I uploaded my Java project on my
professor's server and it gives me an error.  However, if I load the
html file with the Java applet in my web browser from this hard disk
(instead of from the prof's), it works.
	I am wondering if there is some sort of corruption going on here.  I am
using Red Hat's 2.4.9-21 kernel.

Thanks

Kevin Breit




