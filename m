Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268018AbUHKKK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268018AbUHKKK7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHKKK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:10:59 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:54793 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S268018AbUHKKK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:10:57 -0400
Date: Wed, 11 Aug 2004 12:10:56 +0200
From: DervishD <disposable1@telefonica.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compiling glibc
Message-ID: <20040811101056.GA3673@DervishD>
Mail-Followup-To: Linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    Per section 1.8 of the glibc FAQ, I understand that if I build a
glibc using headers from 2.4.26, it not necessarily will run
correctly on 2.4.27. Is this true or this maybe-incompatibility
applies only for releases and not patchlevels (I mean, compiling in a
2.2.x and running on a 2.4.x)?

    I want to build a new version of the glibc (I use 2.2.4 and I
want to upgrade to 2.3.3) and I need the headers of the kernel I'm
running (2.4.26 or .27 in my case) but, where? I mean: should I
install them under /usr/include? Now I have /usr/include/linux and
/usr/include/asm from my old 2.4.10 kernel, back when I built my old
glibc, they're not symlinks to my current kernel headers, as
recommended here a time ago.

    I'm not sure if I have to put kernel headers from 2.4.26 in
/usr/include/linux and /usr/include/asm when building the new library
or after building it. In the glibc FAQ I cannot find an answer.

    Could anyone help? Any help will be greatly appreciated :) Thanks
a lot in advance.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
