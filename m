Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314619AbSDTN2O>; Sat, 20 Apr 2002 09:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314620AbSDTN2N>; Sat, 20 Apr 2002 09:28:13 -0400
Received: from smtp-server2.cfl.rr.com ([65.32.2.69]:5532 "EHLO
	smtp-server2.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S314619AbSDTN2M>; Sat, 20 Apr 2002 09:28:12 -0400
Message-ID: <3CC16D2E.44C5C1D8@cfl.rr.com>
Date: Sat, 20 Apr 2002 09:29:18 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: apic_routing-2.4.17 patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a version of this patch for 2.4.18. This patch does apply
cleanly to 2.4.18 but all modules create by "make modules
modules_install" give depmod errors.

local_apic_taskpri is an unresolved symbol in every module.
 
This patch  was obtained from http://sourceforge.net/projects/lse.

-- 
Mark Hounschell
dmarkh@cfl.rr.com
