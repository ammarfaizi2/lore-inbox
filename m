Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVD0XDC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVD0XDC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 19:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVD0XDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 19:03:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:7586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262083AbVD0XC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 19:02:56 -0400
Date: Wed, 27 Apr 2005 16:02:11 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11 of 12] Fix Tpm driver -- add cancel function
Message-Id: <20050427160211.1d724a11.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504271654260.3929@jo.austin.ibm.com>
References: <Pine.LNX.4.61.0504271654260.3929@jo.austin.ibm.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2005 17:19:17 -0500 (CDT) Kylene Hall wrote:

| Userspcace needs to be able to cancel functions which have been sent to 
| the TPM (part of the spec.).  Add a sysfs file that communicates this 
| desire to the driver and device.
| 
| Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
| ---

| --- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-27 11:13:29.000000000 -0500
| +++ linux-2.6.12-rc2-tpmdd/drivers/chat/tpm/tpm.c	2005-04-27 11:32:35.000000000 -0500
                                     chat ???  :)
might cause patch(1) problems.

---
~Randy
