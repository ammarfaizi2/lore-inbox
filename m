Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161326AbWHDRGq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161326AbWHDRGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWHDRGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:06:45 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:10950 "EHLO ausmtp06")
	by vger.kernel.org with ESMTP id S1161326AbWHDRGo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:06:44 -0400
Date: Fri, 4 Aug 2006 22:33:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, haveblue@us.ibm.com, pj@sgi.com,
       saw@sawoct.com
Subject: Re: [ProbableSpam] Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu  controller
Message-ID: <20060804170310.GA11904@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D372F5.5000901@sw.ru> <44D37A8C.4000608@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D37A8C.4000608@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2006 at 12:49:16PM -0400, Shailabh Nagar wrote:
> 
> >BTW, to help to compare (as you noted above) here is the list of 
> >features provided by OpenVZ:
> >
> 
> Could you point to a place where we can get a broken-down set of
> patches for OpenVZ or (even better), UBC ?
> 
> For purposes of the resource management discussion, it will be
> useful to be able to look at the UBC patches in isolation
> and perhaps port them over to some common interface for testing
> comparing with other implementations.

Kirill,

Is this the latest set (based on your last publication) for
people to look at ?

http://download.openvz.org/kernel/broken-out/2.6.16-026test005.1/

Thanks
Dipankar
