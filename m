Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbUCETAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 14:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbUCETAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 14:00:01 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:8695 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262679AbUCES75
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:59:57 -0500
Message-ID: <4048CE25.8010705@mvista.com>
Date: Fri, 05 Mar 2004 10:59:49 -0800
From: Steve Longerbeam <stevel@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new special filesystem for consideration in 2.6/2.7
References: <40462AA1.7010807@mvista.com> <4048C245.7060009@mvista.com> <20040305184203.GB26176@redhat.com>
In-Reply-To: <20040305184203.GB26176@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Jones wrote:

>On Fri, Mar 05, 2004 at 10:09:09AM -0800, Steve Longerbeam wrote:
> > >An intro to PRAMFS along with a technical specification
> > >is at the SourceForge project web page at
> > >http://pramfs.sourceforge.net/. A patch for 2.6.3 has
> > >been released at the SF project site. 
> > 
> > 
> > A new patch for 2.6.4 is available, but it and the 2.6.3 patch
> > are each ~2900 lines, so I won't post here. But here's the intro:
>
>Without commenting on the code, the biggest thing holding back
>inclusion of this is likely the comment about there likely being
>patents held on parts of that code.
>
>		Dave
>

Dave, true MV has a patent pending, but it would only affect any future use
of the technology in a _non GPL_ operating system. Used in Linux or any
future GPL software, no patent licenses or royalties are involved at all.

I am not a lawyer, but I think I got that right :)

Steve

