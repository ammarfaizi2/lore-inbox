Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTDYVcz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 17:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbTDYVcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 17:32:55 -0400
Received: from uni02du.unity.ncsu.edu ([152.1.13.102]:47241 "EHLO
	uni02du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S264504AbTDYVcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 17:32:51 -0400
From: jlnance@unity.ncsu.edu
Date: Fri, 25 Apr 2003 17:45:00 -0400
To: linux-kernel@vger.kernel.org
Subject: ia32 kernel on amd64 box?
Message-ID: <20030425214500.GA20221@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    Does anyone know if an ia32 kernel (specifically the one that comes with
Red Hat 7.2) will work on an SMP AMD Opteron machine?
    I know someone will want to know why I would want to, so here is the
explanation.  I want to evaluate the opteron port of Linux at work.  Buying
the Opteron machine is less risky if I can fall back to 32 bit Linux
if the 64 bit port does not work well.  This is particularly true since
the 64 bit servers do not seem to cost much more than similar Pentium
machines.

Thanks,

Jim
