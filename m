Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946974AbWKARpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946974AbWKARpZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946977AbWKARpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:45:25 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:443 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946974AbWKARpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:45:24 -0500
Date: Wed, 1 Nov 2006 23:20:15 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101175015.GA22976@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <45460743.8000501@openvz.org> <20061031163418.GD9588@in.ibm.com> <4548545B.4070701@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4548545B.4070701@openvz.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 11:01:31AM +0300, Pavel Emelianov wrote:
> > Sorry dont get you here. Are you saying we should support different
> > grouping for different controllers?
> 
> Not me, but other people in this thread.

Hmm ..I thought OpenVz folks were interested in having different
groupings for different resources i.e grouping for CPU should be
independent of the grouping for memory.

	http://lkml.org/lkml/2006/8/18/98

Isnt that true?

-- 
Regards,
vatsa
