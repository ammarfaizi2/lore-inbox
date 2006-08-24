Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWHXLUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWHXLUq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWHXLUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:20:46 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37353 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751121AbWHXLUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:20:46 -0400
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dax Kelson <dax@gurulabs.com>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Theodore Bullock <tbullock@nortel.com>,
       robm@fastmail.fm, brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1156408443.3014.40.camel@laptopd505.fenrus.org>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	 <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
	 <20060731200309.bd55c545.akpm@osdl.org>
	 <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
	 <1156375551.4306.10.camel@mentorng.gurulabs.com>
	 <20060824034246.GA18826@suse.de>
	 <1156398960.4256.25.camel@thud.gurulabs.com>
	 <1156408443.3014.40.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 24 Aug 2006 12:41:27 +0100
Message-Id: <1156419687.3007.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-24 am 10:34 +0200, ysgrifennodd Arjan van de Ven:
> > The current Fedora Core 6 development (and consequently RHEL5 and
> > CentOS5) is using 2.6.18-rc kernels (actually as of yesterday, your git
> > tree).
> 
> .. and those distros can't pull in this driver because..... ?

FC6 policy is to follow upstream very closely. RHEL may vary.

I don't think its fair to ask Greg to make this decision and James has
already given a clear answer.

Alan

