Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUCFP1e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 10:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUCFP1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 10:27:34 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:26035 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S261680AbUCFP1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 10:27:33 -0500
Date: Sat, 6 Mar 2004 10:27:32 -0500 (EST)
From: Abhishek Rai <abba@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Subject: rtc_gettimeofday VS. do_gettimeofday
Message-ID: <Pine.LNX.4.44.0403061024150.15658-100000@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I need a mechanism to get accurate timeofday from inside the kernel. 
Though rtc_gettimeofday() and do_gettimeofday() both look appropriate, is 
there a reason to prefer one over the other ?

Thanks !!
Abhishek

