Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWHPSor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWHPSor (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 14:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWHPSor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 14:44:47 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26380 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750744AbWHPSoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 14:44:46 -0400
Date: Wed, 16 Aug 2006 20:44:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: spyro@f2s.com
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: arm26 and gcc 4
Message-ID: <20060816184444.GF7813@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

the arm26 port uses the -mapcs-26 gcc option that was deprecated in
gcc 3.4 and removed in gcc 4.

Is there any way to compile arm26 kernels with gcc 4, or is the arm26 
port already implicitely scheduled for removal when we'll raise the 
minimum gcc version next time?

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

