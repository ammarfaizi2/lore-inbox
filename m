Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWBFUEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWBFUEF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBFUEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:04:05 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:14610 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S932355AbWBFUED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:04:03 -0500
From: Meelis Roos <mroos@linux.ee>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
In-Reply-To: <1139244412.10437.32.camel@localhost.localdomain>
User-Agent: tin/1.8.0-20051224 ("Ronay") (UNIX) (Linux/2.6.16-rc2-g5b7b644c-dirty (i686))
Message-Id: <20060206200400.E69E8142E2@rhn.tartu-labor>
Date: Mon,  6 Feb 2006 22:04:00 +0200 (EET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AC>         http://zeniv.linux.org.uk/~alan/IDE
AC> 
AC> for 2.6.16-rc2 patches.

Should I #define ATA_ENABLE_PATA by hand in include file to get PIIX4
PATA to wotk with the ata_piix driver, or should it just work?

-- 
Meelis Roos
