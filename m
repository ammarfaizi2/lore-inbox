Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbTIDVNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265528AbTIDVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:13:21 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:40940 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265531AbTIDVNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:13:17 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: Rik van Riel <riel@redhat.com>
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Date: Thu, 4 Sep 2003 22:12:25 +0100
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0309041628380.14715-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309041628380.14715-100000@chimarrao.boston.redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309042212.25052.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why would binary drivers be any harder to debug than the existing binary 
kernel. If you want to debug something use the source code. My proposal 
doesn't remove the need for quality public source code but it does isolate 
the kernel components and allow for 'plugin' use on different kernels both 
old and new.

If a relatively small kernel component can be turned on/off and upgraded at 
will, without changing ANYTHING else, this would be a big step forward.

James


On Thursday 04 Sep 2003 9:29 pm, you wrote:
> On Thu, 4 Sep 2003, James Clark wrote:
> > I'm very surprised by the number of posts that have ranted about
> > Open/Close source, GPL/taint issues etc. This is not about source code
> > it is about making Linux usable by the masses.
>
> How would "making it easier to include impossible to debug
> device drivers" help towards your goal of making Linux more
> usable ?

