Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318560AbSIBXPK>; Mon, 2 Sep 2002 19:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318542AbSIBXPK>; Mon, 2 Sep 2002 19:15:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19919 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318538AbSIBXPJ>;
	Mon, 2 Sep 2002 19:15:09 -0400
Date: Mon, 02 Sep 2002 16:13:05 -0700 (PDT)
Message-Id: <20020902.161305.123307098.davem@redhat.com>
To: scott.feldman@intel.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, kuznet@ms2.inr.ac.ru,
       christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would like to praise Intel for working so closely with us on
this.  They gave us immediately, in one email, all the information we
needed to implement and test e1000 support for TSO under Linux.

With some other companies, doing this is like pulling teeth.
