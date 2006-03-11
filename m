Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWCKECZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWCKECZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 23:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCKECZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 23:02:25 -0500
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:54469 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932408AbWCKECK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 23:02:10 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Hugo Vanwoerkom <rociobarroso@att.net.mx>
Subject: Re: [ck] 2.6.15-ck7
Date: Sat, 11 Mar 2006 15:01:51 +1100
User-Agent: KMail/1.9.1
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
References: <200603102221.38779.kernel@kolivas.org> <4411EB84.6030106@att.net.mx>
In-Reply-To: <4411EB84.6030106@att.net.mx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603111501.51669.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 March 2006 08:11, Hugo Vanwoerkom wrote:
> Con Kolivas wrote:
> > These are patches designed to improve system responsiveness and
> > interactivity. It is configurable to any workload but the default ck
> > patch is aimed at the desktop and cks is available with more emphasis on
> > serverspace.
>
> <snip>
>
> I see 2.6.15-ck6 in the list of all patches, but was it announced? Or
> did I miss it? ;-)

ck6 was never announced. It had latest stable and the yield() workaround for 
swap prefetching but because I knew I was working on a better fix for swap 
prefetching I waited till I had that to release another version with it 
(-ck7).

Cheers,
Con
