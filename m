Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUDNXoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDNXhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:37:50 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:2802 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262031AbUDNXel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:34:41 -0400
Subject: Re: IO-APIC on nforce2 [PATCH]
From: Peter Clifton <pcjc2@cam.ac.uk>
To: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, ross@datscreative.com.au
In-Reply-To: <200404142301.33153.christian.kroener@tu-harburg.de>
References: <200404142301.33153.christian.kroener@tu-harburg.de>
Content-Type: text/plain
Message-Id: <1081989304.7831.8.camel@pcjc2>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Thu, 15 Apr 2004 01:35:04 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Christian, meant to send to the list rather than just you.

I'm watching this thread with interest, I've got an ASUS A7N8X board,
and have had annoying lockups with most kernels I've compiled myself
from 2.4 upwards. Some luck caused me to try turning APIC off, and the
system hasn't crashed since.

Is there any reason why turning APIC off reduces performance?

I'd be happy to provide another person to test patches (with the proviso
that if you want detailed debugging information, you'd have to suggest
how to obtain it, since when it locks up, it tends to lock good!)

I'm currently running 2.6.3-gentoo-r1 (Although I can't see a list of
what patches they have already applied).

I'd be happy to try a vanilla kernel with whatever patches if that would
help out solving the problem.

Regards

Peter Clifton


