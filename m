Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbULUOnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbULUOnp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbULUOno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:43:44 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:8076 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S261767AbULUOlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:41:20 -0500
Date: Tue, 21 Dec 2004 15:41:19 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.9: VIA sATA cannot switch to 32bit I/O?
Message-ID: <20041221144119.GA21507@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo l-k,

I have problem with my Abit AV8 MB (s939 with VIA KT800Pro chipset and
VIA sATA controller and 120GB Seagate Barracuda disk): I cannot switch
32bit access to disk to on?! I'm using libata driver...

When I use hdparm -c1 /dev/sda, I've got some error message (sorry, I
haven't this message here, it's my home computer). Therefore disk is too
slow to putting data for burning CD's and I need 'burnfree' feature...

Please, have anyone advice for me to speedup disk access, or is it
possible?

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
