Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264766AbSKZMPM>; Tue, 26 Nov 2002 07:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSKZMPM>; Tue, 26 Nov 2002 07:15:12 -0500
Received: from smtpde02.sap-ag.de ([155.56.68.170]:62612 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S264766AbSKZMPL>; Tue, 26 Nov 2002 07:15:11 -0500
Date: Tue, 26 Nov 2002 13:22:22 +0100
From: Florenz Kley <florenz.kley@sap.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: HT aware scheduler in 2.4?
Message-ID: <20021126122221.GE31604@wdf.sap-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ingo, hi all,

some time ago, you posted a patch for a HT aware scheduling:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0208.3/0449.html

does this run in 2.4 kernels? I am doing testing with P4 machines currently, and would like to get some numbers concerning ht out of this testing. However, this does not seem to make too much sense with a "normal" SMP scheduler.

regards,
Florenz

-- 
florenz.kley@sap.com
Dell Computer Corporation at the SAP LinuxLab
