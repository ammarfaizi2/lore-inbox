Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752045AbWCNQqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045AbWCNQqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 11:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbWCNQqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 11:46:47 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:34998 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1752045AbWCNQqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 11:46:47 -0500
Subject: Re: Bursty I/O in ext3
From: Avishay Traeger <atraeger@cs.sunysb.edu>
To: Tong Li <tongli@cs.duke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
References: <Pine.GSO.4.62.0603140150420.1352@eenie.cs.duke.edu>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 11:46:45 -0500
Message-Id: <1142354805.7079.2.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 02:32 -0500, Tong Li wrote:
> Does anyone have any insight on this, or any suggestion on how to figure 
> it out?

I tried to recreate the condition, but failed (10 runs, all about the
same amount of time).  Is it possible that you have some other process
accessing the partition?

Avishay Traeger
http://www.fsl.cs.sunysb.edu/~avishay/

