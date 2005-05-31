Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVEaRcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVEaRcg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVEaRbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:31:25 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:59869 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261953AbVEaR3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:29:08 -0400
Date: Tue, 31 May 2005 10:28:59 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
Cc: schneelocke@gmail.com, linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: Kernel Version Explanation
Message-Id: <20050531102859.06693f8c.rdunlap@xenotime.net>
In-Reply-To: <429C94B7.1090005@capitalgenomix.com>
References: <20050529140945.GA4815@cgx-mail.capitalgenomix.com>
	<20050529112523.17f6e8fa.rdunlap@xenotime.net>
	<429A792F.9070806@zytor.com>
	<d4dc44d505053010066cdaff3@mail.gmail.com>
	<429C94B7.1090005@capitalgenomix.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2005 12:45:43 -0400 Fao, Sean wrote:

| Schneelocke wrote:
| 
| >On 30/05/05, H. Peter Anvin <hpa@zytor.com> wrote:
| >  
| >
| >>>It looks to me like the word "stable" is overused on the main page
| >>>at www.kernel.org .
| >>>      
| >>>
| >>That's because there isn't an odd-number series right now.
| >>    
| >>
| >
| >Will there ever be one again (at least in the foreseeable future)?
| >We've had "Linus = stable, -mm = unstable" for a long time now, and it
| >seems pretty much official now that there won't be a 2.7 anytime soon.
| >The actual development of new features is happening in the relevant
| >maintainers' trees, anyway, so there simply seems to be no need for a
| >single highly development-oriented tree (like 2.5 was) anymore - quite
| >the contrary.
| >  
| >
| 
| My understanding was that Linus eventually decided upon something in the 
| middle.  I understood that there still wouldn't be a 2.7.x branch 
| (unless major changes occurred, which would severely risk breaking the 
| stable tree).  However, it was also my understanding that Linus would 
| return to the even/odd version system; but, would do so in the rev.  In 
| other words, 2.6.even would be stable, while 2.6.odd would be 
| development.  I did, however, become slightly confused when I connected 
| to http://www.kernel.org and noticed that the latest stable kernel was 
| 2.6.11.11 because it's both odd and contains four version numbers rather 
| than the  three, which we've usually seen.
| 
| Hope that clears up what my confusion is.

The even/odd-ness of 'x' in the 2.6.x version number discussion
was ultimately rejected as far as it having any stable/development/test
meaning.

Mostly Linus's 2.6.x tree is for stable work and Andrew's -mm
patchset is for development work.  However, as I often say,
everything is relative.  There are no absolutes in this.


---
~Randy
