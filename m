Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030581AbWFVDFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbWFVDFe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbWFVDFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:05:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:57195 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030581AbWFVDFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:05:34 -0400
X-IronPort-AV: i="4.06,164,1149490800"; 
   d="scan'208"; a="54932329:sNHT38224200"
Subject: Re: [KORG] ipw2200 firmware
From: Zhu Yi <yi.zhu@intel.com>
To: Tanguy Ortolo <tanguy.ortolo@libertysurf.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4498124F.4070004@libertysurf.fr>
References: <4498124F.4070004@libertysurf.fr>
Content-Type: text/plain
Organization: Intel Corp.
Date: Thu, 22 Jun 2006 11:05:09 +0800
Message-Id: <1150945509.18141.151.camel@debian.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 17:20 +0200, Tanguy Ortolo wrote:
> Hello,
> 
> I saw you patched ipw2200 v1.0.8 driver for it to use ipw2200 firmware
> v3.0. But Documentation/networking/README.ipw2200 sends us to
> <http://ipw2200.sf.net>, that recommends firmware v2.4.
> 
> Could you signal that issue in Documentation/networking/README.ipw2200 ?

Only ipw2200 drivers v1.1.1 and newer support v3.0 format firmware. The
page http://ipw2200.sourceforge.net/firmware.php is correct.

There might be some patch to add the v3.0 firmware format support for
early drivers (e.g. v1.0.8) but that's out of the scope of the document.
When talking about driver versions we refer to the versions from
http://ipw2200.sourceforge.net/downloads.php.

Thanks,
-yi
