Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVCRDfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVCRDfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVCRDfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:35:14 -0500
Received: from fmr21.intel.com ([143.183.121.13]:3777 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261445AbVCRDfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:35:11 -0500
Subject: Re: Error messages with ACPI
From: Len Brown <len.brown@intel.com>
To: Mina Nozar <nozarm@triumf.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <33065.24.85.238.99.1110046181.squirrel@24.85.238.99>
References: <33065.24.85.238.99.1110046181.squirrel@24.85.238.99>
Content-Type: text/plain
Organization: 
Message-Id: <1111116901.9332.141.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Mar 2005 22:35:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-05 at 13:09, Mina Nozar wrote:

> kernel:  ACPI-1133: *** Error: Method execution failed
> [\_SB_.BAT0._BST]
> (Node dfe043c0), AE_AML_NO_RETURN_VALUE

Please try the latest mm tree and report if these go away.


thanks,
-Len


