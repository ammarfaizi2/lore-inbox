Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbTAXAPF>; Thu, 23 Jan 2003 19:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267451AbTAXAPF>; Thu, 23 Jan 2003 19:15:05 -0500
Received: from fmr02.intel.com ([192.55.52.25]:50927 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267447AbTAXAPE>; Thu, 23 Jan 2003 19:15:04 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CACABE@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Austin Gonyou'" <austin@coremetrics.com>, linux-kernel@vger.kernel.org
Subject: RE: Using O(1) scheduler with 600 processes.
Date: Thu, 23 Jan 2003 16:24:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think yes, but I wanted to get some opinions/facts before 
> making that
> choice to go without O(1) sched.

Just go, it will help. Test it first, though :)

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
