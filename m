Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTFYSuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFYSuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:50:16 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:16320
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264949AbTFYSuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:50:14 -0400
Date: Wed, 25 Jun 2003 15:04:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jeremy A Redburn <jredburn@wso.williams.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem detecting SATA drive in 2.4.21-ac2
Message-ID: <20030625190425.GA6701@gtf.org>
References: <Pine.LNX.4.21.0306251437300.24753-100000@olga.williams.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0306251437300.24753-100000@olga.williams.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 02:41:29PM -0400, Jeremy A Redburn wrote:
> Hello,
> 
> I am using the latest 2.4-ac kernel (2.4.21-ac2) and trying to get support
> for my WD Raptor SATA drive. The kernel detects the SATA controller just
> fine and loads it as ide2 and ide3 -- but there is no detection of the
> attached drive (which would presumably be hde). Anyone have any advice for
> me?

It would help if you actually gave us details about your hardware,
beyond what drive it is.  See the file REPORTING-BUGS in the kernel
source for examples.  At a minimum, full lspci and dmesg output.

	Jeff



