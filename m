Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWBJCQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWBJCQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 21:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWBJCQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 21:16:06 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:22696 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750974AbWBJCQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 21:16:05 -0500
Date: Fri, 10 Feb 2006 03:15:59 +0100
From: Voluspa <lista1@telia.com>
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, greg@kroah.com
Subject: Re: [2.6.16-rc2] Error - nsxfeval - And uncool silence from kernel
 hackers.
Message-Id: <20060210031559.4aa6b268.lista1@telia.com>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E044F086A@orsmsx403.amr.corp.intel.com>
References: <971FCB6690CD0E4898387DBF7552B90E044F086A@orsmsx403.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006 15:13:51 -0800 Moore, Robert wrote:
> > ACPI Error (nsxfeval-0242): Handle is NULL and Pathname is relative
> > [20060127]
> 
> This is an extraneous message and has been removed.
> 
> We recently changed all of the DEBUG_PRINT statements with error and
> warning levels to ACPI_ERROR and ACPI_WARNING. There have been a couple
> of messages that now pop out inappropriately, and they have been fixed.

Thank you for the quick jot down. Now the answer is archived for others.

Mvh
Mats Johannesson
--
