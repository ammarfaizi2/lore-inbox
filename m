Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946980AbWKARqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946980AbWKARqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946979AbWKARqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:46:09 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:16791 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1946978AbWKARqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:46:08 -0500
Date: Wed, 1 Nov 2006 23:21:12 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, sekharan@us.ibm.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, dipankar@in.ibm.com,
       rohitseth@google.com, menage@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101175112.GB22976@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org> <20061031163418.GD9588@in.ibm.com> <4548545B.4070701@openvz.org> <1162397041.12419.124.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162397041.12419.124.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 08:04:01AM -0800, Matt Helsley wrote:
> > >> 3. Configfs may be easily implemented later as an additional
> > >>    interface. I propose the following solution:
> > > 
> > > Ideally we should have one interface - either syscall or configfs - and
> > > not both.
> 
> To incorporate all feedback perhaps we should replace "configfs" with
> "filesystem".

Yes, you are right.

-- 
Regards,
vatsa
