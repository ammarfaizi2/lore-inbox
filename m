Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVDLJos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVDLJos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 05:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVDLJos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 05:44:48 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:5785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262085AbVDLJob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 05:44:31 -0400
Date: Tue, 12 Apr 2005 11:43:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Message-ID: <20050412094354.GD1352@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Using CPU hotplug to support suspend/resume SMP. Both S3 and S4 use
> disable/enable_nonboot_cpus API. The S4 part is based on Pavel's
> original S4 SMP patch.

The series looks good to me, but I was not yet able to actually try
it. Will try to do that in few hours.
								Pavel

-- 
Boycott Kodak -- for their patent abuse against Java.
