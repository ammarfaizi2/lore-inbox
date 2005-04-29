Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbVD2Rwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbVD2Rwr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 13:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbVD2Rwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 13:52:47 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46505 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262858AbVD2Rwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 13:52:46 -0400
Subject: i386 'make install' behavior change
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 10:52:41 -0700
Message-Id: <1114797161.9140.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I noticed in 2.6.12-rc3 that 'make install' doesn't depend on vmlinux.
I first noticed this in -mm, and it was discussed a bit here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=111083577531995&w=2

Could you please push that patch to Linus before 2.6.12 finalizes?

-- Dave

