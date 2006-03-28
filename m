Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWC1F0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWC1F0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 00:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWC1F0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 00:26:12 -0500
Received: from ozlabs.org ([203.10.76.45]:33412 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751328AbWC1F0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 00:26:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17448.51252.937620.740306@cargo.ozlabs.ibm.com>
Date: Tue, 28 Mar 2006 16:23:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: cbe-oss-dev@ozlabs.org, Arnd Bergmann <abergman@de.ibm.com>,
       linuxppc-dev@ozlabs.org, "Ryan S. Arnold" <rsa@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [updated patch 1/2] powerpc: hvc_console updates
In-Reply-To: <200603272125.16871.arnd.bergmann@de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203520.909999000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<17447.25413.486950.115568@cargo.ozlabs.ibm.com>
	<200603272125.16871.arnd.bergmann@de.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> These are some updates from both Ryan and Arnd for the hvc_console
> driver:

...

> From: "Ryan S. Arnold" <rsa@us.ibm.com>
> Signed-off-by: "Ryan S. Arnold" <rsa@us.ibm.com>
> Signed-off-by: Arnd Bergmann <abergman@de.ibm.com>

Arnd, please put the From: line as the first non-blank line in the
email body.  That way the git tools will handle it automatically and I
won't have to edit things by hand.

Thanks,
Paul.
