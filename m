Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266172AbUFPFpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266172AbUFPFpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 01:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266174AbUFPFpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 01:45:39 -0400
Received: from corpmail.outblaze.com ([203.86.166.82]:52132 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S266172AbUFPFpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 01:45:38 -0400
Message-ID: <20040616054535.18974.qmail@team.outblaze.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Timothy Webster" <timothyw@outblaze.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Jun 2004 13:45:35 +0800
Subject: tcp v4 csum failed appear after 2.4.18 -2.4.26
X-Originating-Ip: 210.177.227.130
X-Originating-Server: int.hk.outblaze.com
X-Habeas-Swe-1: winter into spring
X-Habeas-Swe-2: brightly anticipated
X-Habeas-Swe-3: like Habeas SWE (tm)
X-Habeas-Swe-4: Copyright 2002 Habeas (tm)
X-Habeas-Swe-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-Swe-6: email in exchange for a license for this Habeas
X-Habeas-Swe-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-Swe-8: Message (HCM) and not spam. Please report use of this
X-Habeas-Swe-9: mark in spam to <http://www.habeas.com/report/>.
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-5; VAE: 6.25.0.62; VDF: 6.25.0.96; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
We have 2 machines which have "hw tcp v4 csum failed" 
after upgrading from 2.4.18 to 2.4.26 
 
If we boot again into the 2.4.18 kernel, we no longer see 
these "hw tcp v4 csum failed" errors. 
 
What has changed, causing the tcp csum errors appear in 
2.4.26? 
 
Thanks  
-tim 
