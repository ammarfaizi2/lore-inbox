Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266270AbUFPMny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbUFPMny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 08:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266272AbUFPMny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 08:43:54 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:19125 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266270AbUFPMnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 08:43:53 -0400
Subject: Re: ld segfault at end of 2.6.6 compile
From: Geoff Mishkin <gmishkin@acs.bu.edu>
Reply-To: gmishkin@bu.edu
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087389831.8669.40.camel@amsa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 08:43:52 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The system has a gig of RAM and a gig of swap, so I don't think it's
running out of space.  Also, ld segfaults immediately after being
invoked, not midway through the link.

As for the memory check, it's a brand new system, but I'll run the check
anyway later today when I get a chance.

Thanks for the tips so far.

			--Geoff Mishkin <gmishkin@bu.edu>

