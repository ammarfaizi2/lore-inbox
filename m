Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVBSKYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVBSKYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 05:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVBSKYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 05:24:15 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:38397 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261675AbVBSKYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 05:24:12 -0500
Date: Sat, 19 Feb 2005 11:24:10 +0100
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Subject: FAUmachine: Looking for a good documented DMA bus master capable PCI IDE Controller card 
Message-ID: <20050219102410.GD16858@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
we just implemented the Intel PIIX DMA Bus Master capable IDE Controller
in FAUmachine. This improved the IO access to virtual IDE Devices using
DMA as transport mechanism a lot.

But with the current simulation it is only possible to access 4 devices
via DMA.

Because of that I am looking for a good documented PCI IDE Controller
Card to provide DMA access to more than 4 devices with public available
documentation. Any pointers?

Please CC me because I am currently not subscribed to linux-kernel.

	Thomas
--
Thomas Glanzmann  ++49 (0) 9131 85-27574   Department of Computer Science III
Martensstrasse 3  D-91058 Erlangen Germany   University of Erlangen-Nuremberg
      http://www3.informatik.uni-erlangen.de/Research/FAUmachine/
