Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVBJT3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVBJT3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 14:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVBJT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 14:28:56 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:51110 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S261365AbVBJT0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 14:26:00 -0500
Date: Thu, 10 Feb 2005 21:25:54 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]   Samsung P35, S3, black screen (radeon))
Message-ID: <20050210192554.GA15726@sci.fi>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
	Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
	Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	ACPI List <acpi-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1107695583.14847.167.camel@localhost.localdomain> <420BB267.8060108@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <420BB267.8060108@tmr.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW it seems that old ATI cards use the BIOS to initialize secondary 
adapters even under Windows.
See http://www.ati.com/support/infobase/3663.html.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
