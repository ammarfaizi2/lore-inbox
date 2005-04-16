Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVDPHJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVDPHJg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 03:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVDPHJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 03:09:33 -0400
Received: from jose.lug.udel.edu ([128.175.60.112]:33677 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S261167AbVDPHJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 03:09:29 -0400
From: ross@lug.udel.edu
Date: Sat, 16 Apr 2005 03:09:25 -0400
To: linux-kernel@vger.kernel.org
Subject: DRM not working with 2.6.11.5
Message-ID: <20050416070925.GA1237@jose.lug.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I recently upgraded to 2.6.11.5 (back when it came out) from 2.4.
One of the reasons I upgraded was to get DRM working with my computer
again.

The AGP and DRM modules load fine, but when xdm starts, I have no
direct rendering.

The machine is an ASUS A7V8x-x with VIA chipset KT400.  The video card
is a Matrox G400 DualHead.  I've had the exact same video card working
with different motherboards.


Here is the only DRM output relevant to AGP/DRM:

Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized drm 1.0.0 20040925
[drm:drm_fill_in_dev] *ERROR* Cannot initialize the agpgart module.
DRM: Fill_in_dev failed.

Thanks very much for any tips!


-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
