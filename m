Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268603AbUHLQah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268603AbUHLQah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268605AbUHLQah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:30:37 -0400
Received: from pop.gmx.de ([213.165.64.20]:3477 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268603AbUHLQaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:30:35 -0400
X-Authenticated: #14776911
From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger@gmx.at>
Reply-To: stefandoesinger@gmx.at
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: Allow userspace do something special on overtemp
Date: Thu, 12 Aug 2004 19:27:10 +0200
User-Agent: KMail/1.6.2
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       trenn@suse.de, seife@suse.de,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040811085326.GA11765@elf.ucw.cz> <1092323945.5028.177.camel@dhcppc4>
In-Reply-To: <1092323945.5028.177.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121927.11277.stefandoesinger@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Isn't this a little bit dangerous? What if acpid is not set up to handle this?
