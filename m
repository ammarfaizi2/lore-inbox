Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbTDKOxs (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTDKOxs (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:53:48 -0400
Received: from 12-229-131-42.client.attbi.com ([12.229.131.42]:11146 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264381AbTDKOxr (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 10:53:47 -0400
Message-ID: <3E96D9B5.5060704@comcast.net>
Date: Fri, 11 Apr 2003 08:05:25 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030409
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ck5
References: <3E96D711.70404@comcast.net> <200304120101.32423.kernel@kolivas.org>
In-Reply-To: <200304120101.32423.kernel@kolivas.org>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> 
> XFS must be responsible. I can't test it fully myself but it appears to be 
> related to the latest xfs update I've included in -ck5 which is a snapshot 
> from the sgi website only a week old. Until further notice, use ck4 if you 
> wish to use XFS.
> 
> Thanks for the feedback.
> 
> Con
> 

Thanks Con. Now that I think about it, I probably should've cc'd the xfs
list. There was some work done on memory leaks in XFS recently -
something in here must expose additional leaks. Thanks again,

-Walt


