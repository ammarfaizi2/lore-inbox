Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVBOPbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVBOPbP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 10:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVBOPbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 10:31:15 -0500
Received: from fmr14.intel.com ([192.55.52.68]:52402 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261755AbVBOPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 10:31:08 -0500
Subject: Re: [ACPI] [PATCH, new ACPI driver] new sony_acpi driver
From: Len Brown <len.brown@intel.com>
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20050210161809.GK3493@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr>
Content-Type: text/plain
Organization: 
Message-Id: <1108481448.2097.71.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Feb 2005 10:30:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 11:18, Stelian Pop wrote:,

> 
> PS: I am also going to submit a bugzilla RFE for the acpi people,
> I have been told they are more receptive to that.

I guess that refers to me:-)

E-mail is fine, but the unfortunate reality is that due to simple
volume, it is lossy.  The reason we like bugzilla is that it never
forgets:-)

So thanks for taking the extra time to file a bug report
http://bugzilla.kernel.org/show_bug.cgi?id=4193

If it turns out that there is no way a generic solution
can handle the SNC Sony laptops, then I agree that a
platform specific wart is the only way to go.  But
it would be best if we can make the exotic Sony/SNC
look more generic to the user so that the user
(and the distro supporting them) don't need to learn
special things to handle this system.

thanks,
-Len


