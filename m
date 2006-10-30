Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751541AbWJ3M2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbWJ3M2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 07:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWJ3M2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 07:28:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48084 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751532AbWJ3M17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 07:27:59 -0500
Date: Mon, 30 Oct 2006 04:27:14 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-Id: <20061030042714.fa064218.pj@sgi.com>
In-Reply-To: <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
	<20061030031531.8c671815.pj@sgi.com>
	<6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> I was thinking that it would be even better if the actual (human)
> users could determine this; have the container infrastructure make it

You mean let the system admin, say, of a system determine
whether or not CKRM/RG and cpusets have one shared, or two
separate, hierarchies?

Wow - I think my brain just exploded.

Oh well ... I'll have to leave it an open issue for the moment;
I'm focusing on something else right now.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
