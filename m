Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVCCMFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVCCMFB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCCMCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:02:19 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:22847 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261618AbVCCLJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 06:09:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=WLVurC70w4skrSvOnqRrDRle5L+6rkHb0JatQ/+3dpPCwjrIJXuwM8CXXUMvfrYXVjvSPR+Wlc8MNlNH5mkuoguK8+n6U25m/3hevVK1IofMGz0bRmSc1zEKLgnxhsbme2alHaYNYS6n1TSGFg0/IXW3//kUp+zva+1kV/oOJD4=
Message-ID: <4d8e3fd30503030308d162153@mail.gmail.com>
Date: Thu, 3 Mar 2005 12:08:44 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Reply-To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Prakash Punnoor <prakashp@arcor.de>
Subject: Re: RFD: Kernel release numbering
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4226E6F3.2030803@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <20050303002047.GA10434@kroah.com>
	 <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
	 <200503022121.07679.gene.heskett@verizon.net>
	 <4226E6F3.2030803@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2005 11:29:07 +0100, Prakash Punnoor <prakashp@arcor.de> wrote:
[...]
> And if you want bug reports, make it easier for the user. I know there is a
> txt file in the kernel src dir, but it would be better, if there would be a
> complete script which gets all possible need infos itself. Then user driven
> input could be minimized.

Yup, having an interactive script that produce a bug-report-date.txt
file would be great.
Furthemore I don't understand why bugzilla is not used  as the main
bug reporting tool.

> Furthermore many users are simple afraid to post to lkml. (They report to
> forums, but don't want to report to lkml.) Even I often tend to think: Ok, I
> came across a small bug. Should I post it or should I wait till next rc?
> Usually I wait, because I feel like getting on people's nerves when I post
> every little tidbit. Esp if bugreports seem to get ignored motivation goes
> down to report again...
> 
> Nevertheless, for a fun loving desktop user, I enjoy the pace the linux kernel
> is evolving. It was so "boring" the 2.4 days. But on the other hand linux
> kernel now tends to break various things with each release. I think esp nvidia
> users now about it...

Nvidia binary driver is a totaly different problem.
 
-- 
Paolo <paolo dot ciarrocchi at gmail dot com>
msn: paolo407@hotmail.com
hello: ciarrop
paoloc.blogspot.com
