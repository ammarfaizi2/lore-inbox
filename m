Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUCHAML (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUCHAML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:12:11 -0500
Received: from ccs.covici.com ([209.249.181.196]:23506 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id S262352AbUCHALw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:11:52 -0500
To: linux-kernel@vger.kernel.org
Subject: shuttle an50r Motherboard and Linux
From: John Covici <covici@ccs.covici.com>
Date: Sun, 07 Mar 2004 19:11:50 -0500
Message-ID: <m3wu5w8aex.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have had a couple of problems trying to get this Motherboard
to work correctly under Linux.  

The Ethernet 10/100 is supposed to be an RC82540m, but the e100
module does not recognize it.  If you do an lspci it doesn't say
Intel at all, but just Nvidia and Shuttle.  Am I doing something
wrong, or is there a better driver in 2.6 than 2.4 or what?

Also, I am using the amd74xx driver for the chip set, but it does not
seem to activate dma or announce udma and a number as the via one
does -- is this the correct driver?

Any assistance would be appreciated.

-- 
         John Covici
         covici@ccs.covici.com
