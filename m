Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbUKKSaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbUKKSaV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbUKKRhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:37:50 -0500
Received: from peabody.ximian.com ([130.57.169.10]:40422 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262308AbUKKRVu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:21:50 -0500
Subject: Re: mmap vs. O_DIRECT
From: Robert Love <rml@novell.com>
To: Avi Kivity <avi@argo.co.il>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <41939F21.2040008@argo.co.il>
References: <cmtsoo$j55$1@gatekeeper.tmr.com>
	 <1100121230.4739.1.camel@betsy.boston.ximian.com> <41937C1A.30800@tmr.com>
		 <1100187716.5358.5.camel@localhost> <1100193219.5358.25.camel@localhost>
	  <41939F21.2040008@argo.co.il>
Content-Type: text/plain
Date: Thu, 11 Nov 2004 12:22:36 -0500
Message-Id: <1100193756.5358.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-11 at 19:19 +0200, Avi Kivity wrote:

> Or you can use aio with O_DIRECT.

Ah, indeed.  I was thinking from the kernel's perspective.

	Robert Love


