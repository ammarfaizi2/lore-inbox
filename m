Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWKBAjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWKBAjy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWKBAjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:39:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45241 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751254AbWKBAjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:39:53 -0500
Date: Wed, 1 Nov 2006 16:39:16 -0800
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, vatsa@in.ibm.com, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com
Subject: Re: [ckrm-tech] RFC: Memory Controller
Message-Id: <20061101163916.eca92a2a.pj@sgi.com>
In-Reply-To: <6599ad830611011609t123bba47hf2f3b9a4191d6c12@mail.gmail.com>
References: <20061030103356.GA16833@in.ibm.com>
	<6599ad830610300304l58e235f7td54ef8744e462a55@mail.gmail.com>
	<4545FDCD.3080107@in.ibm.com>
	<6599ad830610301014l1bf78ce8q998229483d055a90@mail.gmail.com>
	<454782D2.3040208@in.ibm.com>
	<6599ad830610310922p61913cdaqb441a2cb718420a9@mail.gmail.com>
	<4548472A.50608@in.ibm.com>
	<6599ad830610312307i549f5a51h3b7a1744a14919f5@mail.gmail.com>
	<45485046.6080508@in.ibm.com>
	<20061101042341.83cbd77e.pj@sgi.com>
	<6599ad830611011609t123bba47hf2f3b9a4191d6c12@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M wrote:
> That can negatively affect the
> performance of other tasks, which is what we're trying to prevent.

That sounds like a worthwhile goal.  I agree that zone_reclaim
doesn't do that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
