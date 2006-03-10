Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWCJVKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWCJVKD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWCJVKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:10:03 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:54974 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S932257AbWCJVKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:10:01 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [2.6.16-rc5-git13] Xorg.log difference
Date: Fri, 10 Mar 2006 22:08:30 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <5038a3.6a2ae9@familynet-international.net>
In-Reply-To: <5038a3.6a2ae9@familynet-international.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603102208.31729.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I see the same, but use 2.6.16-rc4 and didn't report before, 
because I switched from Debian/Sarge to Kubuntu/Dapper
which changed just to much for proper report.

I disabled vm86-support and run on a Dual PIII with an ATI-Rage XL
using the same driver.

Did you disable vm86 support, too?

# CONFIG_VM86 is not set

Regards

Ingo Oeser
