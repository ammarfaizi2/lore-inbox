Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVBXVgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVBXVgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVBXVgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 16:36:36 -0500
Received: from hell.org.pl ([62.233.239.4]:57861 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262474AbVBXVgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 16:36:31 -0500
Date: Thu, 24 Feb 2005 22:36:33 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Norbert Preining <preining@logic.at>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       Pavel Machek <pavel@suse.cz>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
Subject: Re: [ACPI] Call for help: list of machines with working S3
Message-ID: <20050224213633.GA14522@hell.org.pl>
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	Pavel Machek <pavel@suse.cz>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>, seife@suse.de,
	rjw@sisk.pl
References: <20050214211105.GA12808@elf.ucw.cz> <20050215125555.GD16394@gamma.logic.tuwien.ac.at> <42121EC5.8000004@gmx.net> <20050215170837.GA6336@gamma.logic.tuwien.ac.at> <20050222220828.GB538@hell.org.pl> <20050224123716.GD28961@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20050224123716.GD28961@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Norbert Preining:
> - X.Org 6.8.1.99 (debian -dri-trunk stuff plus kernel modules9
> 	no work
> 	with 2.6.11-rc4 and 2.6.11-rc3-mm2
> 	this server crashes when switching to the console or shutting
> 	down (crashing is sometimes, not always), very nice screen which
> 	slowly turns white

This is either distribution or hardware specific. Try with vanilla 6.8.2
and stock DRM modules, perhaps?
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
