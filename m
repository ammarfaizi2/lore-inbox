Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVHSWpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVHSWpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 18:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVHSWpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 18:45:41 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:21514 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S932303AbVHSWpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 18:45:40 -0400
Message-ID: <43066106.6080506@symas.com>
Date: Fri, 19 Aug 2005 15:45:26 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050810 SeaMonkey/1.0a
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com> <20050819065909.GA2249@taniwha.stupidest.org>
In-Reply-To: <20050819065909.GA2249@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
>  On Thu, Aug 18, 2005 at 11:03:45PM -0700, Howard Chu wrote:
> > If the 2.6 kernel makes this programming model unreasonably slow,
> > then quite simply this kernel is not viable as a database platform.

>  Pretty much everyone else manages to make it work.

And this contributes to the discussion how? Pretty much every other 
Unix-ish operating system manages to make scheduling with nice'd 
processes work. If you really want to get into what "everyone else 
manages to make work" you're in for a rough ride.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

