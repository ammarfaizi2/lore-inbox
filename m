Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVEJV4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVEJV4a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEJV43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:56:29 -0400
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:27153 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S261832AbVEJV4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:56:11 -0400
Message-ID: <42812E89.4070301@gentoo.org>
Date: Tue, 10 May 2005 22:58:33 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
CC: linux-kernel@vger.kernel.org, Alan Lake <alan.lake@lakeinfoworks.com>,
       petero2@telia.co.uk, vojtech@suse.cz, stuart@zeus.com
Subject: ALPS touchpad issues still exist in 2.6.12-rc4
References: <42801AEE.5080308@lakeinfoworks.com> <200505092305.45788.dtor_core@ameritech.net>
In-Reply-To: <200505092305.45788.dtor_core@ameritech.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-UoM: Scanned by the University Mail System. See http://www.mcc.ac.uk/cos/email/scanning for details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dmitry Torokhov wrote:
> Do you have an ALPS touchpad? Try applying Peter Osterlund's patches
> from here:
> 
> http://web.telia.com/~u89404340/patches/touchpad/2.6.11/

Even with these patches applied, some Gentoo users are still reporting
problems with ALPS touchpads. Are there any suggested solutions for
http://bugzilla.kernel.org/show_bug.cgi?id=4281 ?

Also see http://bugs.gentoo.org/show_bug.cgi?id=84657

Thanks,
Daniel
