Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423995AbWKIDzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423995AbWKIDzA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 22:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423996AbWKIDzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 22:55:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:57241 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423995AbWKIDy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 22:54:59 -0500
Date: Thu, 9 Nov 2006 09:24:52 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Chris Friesen" <cfriesen@nortel.com>
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       Paul Jackson <pj@sgi.com>, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, Paul Menage <menage@google.com>
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061109035452.GC522@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061101172540.GA8904@in.ibm.com> <6599ad830611011537i2de812fck99822d3dd1314992@mail.gmail.com> <20061106124948.GA3027@in.ibm.com> <6599ad830611061223m77c0ef1ei72bd7729d9284ec6@mail.gmail.com> <20061107104118.f02a1114.pj@sgi.com> <6599ad830611071107u4226ec17h5facc7ee2ad53174@mail.gmail.com> <6599ad830611071421s7792bbb1qd9c7b1fc840dfa50@mail.gmail.com> <20061107191518.c094ce1a.pj@sgi.com> <20061108051257.GB2964@in.ibm.com> <45522F1E.8040002@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45522F1E.8040002@nortel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 01:25:18PM -0600, Chris Friesen wrote:
> Srivatsa Vaddagiri wrote:
> 
> > As was discussed in a previous thread, having a 'threads' file also will
> > be good.
> > 
> > 	http://lkml.org/lkml/2006/11/1/386
> 
> > Writing to 'tasks' file will move that single thread to the new
> > container. Writing to 'threads' file will move all the threads of the
> > process into the new container.
> 
> That's exactly backwards to the proposal that you linked to.

Oops ..yes. Thanks for correcting me!

-- 
Regards,
vatsa
