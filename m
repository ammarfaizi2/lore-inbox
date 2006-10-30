Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWJ3M3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWJ3M3E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWJ3M3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:29:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:54740 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751550AbWJ3M3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:29:01 -0500
Date: Mon, 30 Oct 2006 04:28:33 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030042833.7f3e54f4.pj@sgi.com>
In-Reply-To: <6599ad830610300407x674059ebh8337d05a4e8ebe85@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	<20061030030635.98563962.pj@sgi.com>
	<6599ad830610300407x674059ebh8337d05a4e8ebe85@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> it seems that it would be good to come up with a
> real-world example of something that *can't* make do with this before
> adding extra book-keeping.

that seems reasonable enough ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
