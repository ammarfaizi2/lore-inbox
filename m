Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVIHIWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVIHIWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVIHIWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:22:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932151AbVIHIWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:22:49 -0400
Date: Thu, 8 Sep 2005 01:22:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] ACPI for 2.6.14
Message-Id: <20050908012219.6b5431b7.akpm@osdl.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F04@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048B3F04@hdsmsx401.amr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brown, Len" <len.brown@intel.com> wrote:
>
> I saw lots of transient battery issues from 2.6.13-rc3
>  until 2.6.13-rc6, but the ones I followed went away
>  as of 2.6.13 final.  Do you have your eye on others
>  besides 4980?

Not specifically, but then ACPI bugs are the one sort which I don't track. 
a) because there are so many and b) because the ACPI team use bugzilla
well.

Sticking "battery" into the bugzilla Summary field turns up a few. 
<vague>There seem to have been four or five reports in recent weeks.
