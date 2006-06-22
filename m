Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161133AbWFVOAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161133AbWFVOAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWFVOAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 10:00:15 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:1293 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1161136AbWFVOAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 10:00:13 -0400
Message-ID: <449AA267.5010405@argo.co.il>
Date: Thu, 22 Jun 2006 17:00:07 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: raven@themaw.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: AGPGART: unable to get memory for graphics translation table.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2006 14:00:10.0722 (UTC) FILETIME=[2D17FC20:01C69604]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven <at> themaw.net> writes:

 >
 > On Sat, 17 Jun 2006, Dave Jones wrote:
 >
 > > On Sat, Jun 17, 2006 at 01:24:58PM +0800, Ian Kent wrote:
 > >
 > >  > Linux raven.themaw.net 2.6.16-1.2289_FC6xen #1 SMP Thu Jun 15 
14:48:53 EDT
 > >                                            ^^^
 > >
 > > I'll bet xen is to blame.  Can you try it on a plain kernel.org kernel?
 >
 > I tell a lie.
 >
 > Standard kernel now works.
 > All I noticed between the dmesg files was that the init of the 
agpgart is
 > somewhat later with the xen kernel.

I'm getting this too. Were you able to resolve this somehow?

-- 
error compiling committee.c: too many arguments to function

