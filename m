Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315282AbSHIQls>; Fri, 9 Aug 2002 12:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSHIQls>; Fri, 9 Aug 2002 12:41:48 -0400
Received: from dc-mx09.cluster1.charter.net ([209.225.8.19]:27562 "EHLO
	dc-mx09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S315282AbSHIQlr>; Fri, 9 Aug 2002 12:41:47 -0400
Date: Fri, 9 Aug 2002 12:45:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Patch to enable K6-2 and K6-3 processor optimizations
Message-ID: <20020809164526.GA3026@cy599856-a>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020809014840.4e81fbd3.dbronaugh@linuxboxen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809014840.4e81fbd3.dbronaugh@linuxboxen.org>
User-Agent: Mutt/1.4i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.19-ac4 i686
X-Processor: Athlon XP 2000+
X-Uptime: 11:29:31 up 3 min,  2 users,  load average: 1.25, 0.54, 0.21
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Fri, Aug 09, 2002 at 01:48:40AM -0700, David Bronaugh wrote:
> Hi,
> 
> This is my first kernel patch, so please go easy on me :)
> 
> What it does is conditionally enable -march=k6-2 and -march=k6-3, and provide options for each in the Processor Type and Features menu.
> 

Alan and/or Luca Barbiera,

Could we get this stuff into 2.4-ac at least?  Luca, if you could backport your 2.5 patch that
would be great.  I have attempted to but there is just to many things changed between 2.4 and
2.5 for me to feel comfortable with.

Thanks,
Josh McKinney  
