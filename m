Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSJYDt1>; Thu, 24 Oct 2002 23:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSJYDt0>; Thu, 24 Oct 2002 23:49:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14229 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261271AbSJYDtY>;
	Thu, 24 Oct 2002 23:49:24 -0400
Date: Thu, 24 Oct 2002 20:55:26 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: SL Baur <steve@kbuxd.necst.nec.co.jp>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Forward port of aic7xxx driver to 2.5.44 [1/3]
Message-ID: <20021024205526.A23827@eng2.beaverton.ibm.com>
Mail-Followup-To: SL Baur <steve@kbuxd.necst.nec.co.jp>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <15800.43219.216824.411355@sofia.bsd2.kbnes.nec.co.jp>; from steve@kbuxd.necst.nec.co.jp on Fri, Oct 25, 2002 at 11:13:39AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 11:13:39AM +0900, SL Baur wrote:
> Hi,
> 
> This patch updates the aic7xxx driver to be the same version as in
> 2.4.20-pre11.  The version currently in 2.5.44 is too old to recognize
> my controller.  It compiles cleanly, but I have not yet tried to boot
> with it.  Would someone with experienced eyes please look it over to
> be sure I didn't do anything stupid?  Thanks.
> 

You must have missed Justin's post:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103534482111734&w=2

Pointing to this file:

http://people.FreeBSD.org/~gibbs/linux/linux-2.5-aic79xxx.tar.gz

The above still needs changes, but they should be pretty small.

-- Patrick Mansfield
