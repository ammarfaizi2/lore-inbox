Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbVLHIKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVLHIKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 03:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVLHIKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 03:10:24 -0500
Received: from eos.cs.nthu.edu.tw ([140.114.71.71]:36259 "EHLO
	eos.cs.nthu.edu.tw") by vger.kernel.org with ESMTP id S1750777AbVLHIKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 03:10:23 -0500
From: "yen" <yen@eos.cs.nthu.edu.tw>
To: linux-kernel@vger.kernel.org
Subject: IRQ vector assignment for system call exception
Date: Thu, 8 Dec 2005 16:10:20 +0800
Message-Id: <20051208080435.M54890@eos.cs.nthu.edu.tw>
X-Mailer: Open WebMail 2.41 20040926
X-OriginatingIP: 140.114.71.247 (yen)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=big5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
   I have a quwstion. Why the number 128 is reserver for system call exception in 
interrupt vectors? Why not other numbers? Are there any historical reasons?
thanks.
                  
--
Open WebMail Project (http://openwebmail.org)

