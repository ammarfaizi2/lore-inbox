Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUGGU4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUGGU4h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUGGUzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 16:55:25 -0400
Received: from fmr11.intel.com ([192.55.52.31]:38559 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265489AbUGGUxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 16:53:36 -0400
Subject: Re: problems getting SMP to work with vanilla 2.4.26
From: Len Brown <len.brown@intel.com>
To: Zack Brown <zbrown@tumblerings.org>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FF683@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089233605.15653.498.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 07 Jul 2004 16:53:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-03 at 22:05, Zack Brown wrote:

How about if you increase this to 4?

> CONFIG_NR_CPUS=2


