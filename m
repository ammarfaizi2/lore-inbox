Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTLHWon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTLHWon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:44:43 -0500
Received: from imag.imag.fr ([129.88.30.1]:24470 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S261868AbTLHWom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:44:42 -0500
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: BTTV option not available in make gconfig
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Mon, 08 Dec 2003 23:44:38 +0100
Message-ID: <vpq1xrfnd49.fsf@ecrins.imag.fr>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all ! 

I'm upgrading my kernel to 2.6-test9

The option CONFIG_VIDEO_BT848=m in .config was available in 2.4, but I
can't find in  doing a "make gconfig" in the new  version. (This is to
manage my Pinnacle PCTV card)

However,  the files  related  to bttv  are  still there,  so, this  is
probably a trivially solvable problem. 

-- 
Matthieu
