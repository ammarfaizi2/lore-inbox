Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265429AbUGGUps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbUGGUps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265446AbUGGUps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:45:48 -0400
Received: from fmr10.intel.com ([192.55.52.30]:4802 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S265429AbUGGUpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:45:47 -0400
Subject: Re: /proc/acpi/battery/BAT1/state shows wrong battery state
	(correct after some 'cat's)
From: Len Brown <len.brown@intel.com>
To: w15mail@yahoo.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF6FF@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF6FF@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089233144.15675.483.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Jul 2004 16:45:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both windows and Linux start off with the
wrong battery status, but after some queries
they get it right.  This suggests a hardware-dependent
model-specific quirk.

-Len


