Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUBDRrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 12:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUBDRrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 12:47:53 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:46565 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S263388AbUBDRrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 12:47:52 -0500
Date: Wed, 4 Feb 2004 11:47:48 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: usb mouse/keyboard problems under 2.6.2
Message-ID: <20040204174748.GA27554@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux yggdrasil 2.6.2 #1 SMP Wed Feb 4 07:53:07 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing frequent issues with my usb mouse under the 2.6.2 kernel, in
which the pointer will suddenly freeze.  It remains stuck until I tap a
key on the keyboard, at which point it continues working normally (for
a little while).  Also, the keyboard occasionally acts like a key is
stuck down, which ends promptly when I move the mouse.

The mouse is an ordinary Logitech wheel-mouse and the keyboard is a
Microsoft Natural, both of which are connected via an Avocent
SwitchView USB KVM switch.  The combination works flawlessly under
2.6.1.

Please let me know what additional information I should provide. 
Thanx!
