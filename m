Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSKACVB>; Thu, 31 Oct 2002 21:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265582AbSKACVB>; Thu, 31 Oct 2002 21:21:01 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58056 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265581AbSKACVB>;
	Thu, 31 Oct 2002 21:21:01 -0500
Date: Thu, 31 Oct 2002 18:17:08 -0800 (PST)
Message-Id: <20021031.181708.102783497.davem@redhat.com>
To: krkumar@us.ibm.com
Cc: kuznet@ms2.inr.ac.ru, ajtuomin@tml.hut.fi, lpetande@tml.hut.fi,
       jagana@us.ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200211010219.gA12JMn11699@eng2.beaverton.ibm.com>
References: <200211010219.gA12JMn11699@eng2.beaverton.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why isn't the home agent code being done in userspace?  That is
where it belongs.  It's huge.
