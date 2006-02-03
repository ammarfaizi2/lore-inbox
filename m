Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422854AbWBCTKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422854AbWBCTKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbWBCTKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:10:09 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:14223 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1422854AbWBCTKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:10:07 -0500
Date: Fri, 3 Feb 2006 20:10:00 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Phillip Susi <psusi@cfl.rr.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: RAID5 unusably unstable through 2.6.14
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9963@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0602032009400.24081@kepler.fjfi.cvut.cz>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F021C9963@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Salyzyn, Mark wrote:

> Martin Drab [mailto:drab@kepler.fjfi.cvut.cz] sez:
> > That's why I still think there are no bad sectors at all (at 
> > least not because of this). Is there any way to actually find out?
> 
> Run the Verify (or Verify with Fix) Task on the controller, the report
> will indicate the reasons for inconsistencies.

How do I run that? Any special tools for that?

Martin
