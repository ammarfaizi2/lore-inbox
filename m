Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVBOUz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVBOUz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVBOUz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:55:58 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:17637 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261886AbVBOUyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:54:37 -0500
Subject: Re: [RFC 2.6.11-rc2-mm2 7/7] mm: manual page migration --
	sys_page_migrate
From: Dave Hansen <haveblue@us.ibm.com>
To: Robin Holt <holt@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, Ray Bryant <raybry@sgi.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>, hugh@veritas.com,
       Andrew Morton <akpm@osdl.org>, marcello@cyclades.com,
       raybry@austin.rr.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050215185943.GA24401@lnx-holt.americas.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
	 <20050212032620.18524.15178.29731@tomahawk.engr.sgi.com>
	 <1108242262.6154.39.camel@localhost>
	 <20050214135221.GA20511@lnx-holt.americas.sgi.com>
	 <1108407043.6154.49.camel@localhost>
	 <20050214220148.GA11832@lnx-holt.americas.sgi.com>
	 <20050215074906.01439d4e.pj@sgi.com>
	 <20050215162135.GA22646@lnx-holt.americas.sgi.com>
	 <20050215083529.2f80c294.pj@sgi.com>
	 <20050215185943.GA24401@lnx-holt.americas.sgi.com>
Content-Type: text/plain
Date: Tue, 15 Feb 2005 12:54:22 -0800
Message-Id: <1108500863.16958.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the interest of the size of everyone's inboxes, I mentioned to Ray
that we might move this discussion to a smaller forum while we resolve
some of the outstanding issues.  Ray's going to post a followup to to
linux-mm, and trim the cc list down.  So, if you're still interested,
keep your eyes on linux-mm and we'll continue there.  

-- Dave

