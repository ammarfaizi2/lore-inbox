Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbULUCqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbULUCqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 21:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbULUCqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 21:46:15 -0500
Received: from fmr14.intel.com ([192.55.52.68]:52155 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261266AbULUCqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 21:46:08 -0500
Subject: Re: Need interactive ACPI interpreter
From: Len Brown <len.brown@intel.com>
To: "John S. Worley" <jsworley@qwest.net>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <41C07FBD.90108@qwest.net>
References: <41C07FBD.90108@qwest.net>
Content-Type: text/plain
Organization: 
Message-Id: <1103597163.11833.3735.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Dec 2004 21:46:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 13:17, John S. Worley wrote:
> Hi all -
> 
>      I am looking for a user-mode, interactive ACPI
> interpreter under Linux. Specifically, I need to be able
> to load arbitrary ACPI file(s) (AML or ASL) and then execute
> the methods and see the results. If it can read from
> /proc as well, so much the better.

The ACPI interpreter that we use in the Linux kernel
is also available as a standalone acpiexec program here:

http://www.intel.com/technology/IAPC/acpi/downloads.htm

cheers,
-Len


