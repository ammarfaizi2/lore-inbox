Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129521AbQLJKvy>; Sun, 10 Dec 2000 05:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbQLJKvo>; Sun, 10 Dec 2000 05:51:44 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19472 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129521AbQLJKvc>; Sun, 10 Dec 2000 05:51:32 -0500
Date: Sun, 10 Dec 2000 04:16:59 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18 Frame Buffer Problem with DELL
Message-ID: <20001210041659.A17524@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan/Linux,

I will post the DELL Laptop information on the chipsets Monday relative
to this problem.  If someone else has some DELL hardware to test,
I have posted the Ute-Linux ISO's at vger.timpanogas.org that use 
the 2.2.18pre-25 kernel integrated with David Hinds PCMCIA 3.1.22
and modutils 2.3.20.  They are at

Binary RPM
ftp://vger.timpanogas.org/ute-linux-iso/ute-bin-2.2.18-12102000.iso
Source RPM
ftp://vger.timpanogas.org/ute-linux-iso/ute-src-2.2.18-12102000.iso

This release has 2.2.18-25 integrated into the anaconda installer.  
This is the release I am seeing the DELL laptop problems when 
framebuffer is enabled under 2.2.18-25.  This is kindof tough to test 
properly without the integrated installer, so I have posted 
the iso's early if someone out there wants to help test with these
laptop problems.  IBM Thankpads passed with flying colors, BTW.

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
