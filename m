Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315245AbSEFWnT>; Mon, 6 May 2002 18:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSEFWnS>; Mon, 6 May 2002 18:43:18 -0400
Received: from codepoet.org ([166.70.14.212]:4789 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315245AbSEFWnR>;
	Mon, 6 May 2002 18:43:17 -0400
Date: Mon, 6 May 2002 16:43:19 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [ANN] NTFS 2.0.6a for Linux 2.4.18
Message-ID: <20020506224318.GA27527@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Pawel Kot <pkot@linuxnews.pl>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.33.0205070025140.19921-100000@bzzzt.slackware.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue May 07, 2002 at 12:27:17AM +0200, Pawel Kot wrote:
> Hi all,
> 
> With much help from Anton, I backported the NTFS-TNG driver to 2.4.x Linux
> kernel series. If you are afraid of running 2.5.x kernel, but you would
> like to get all benefits of the new NTFS driver use this one.
> 
> It should have all features the driver for 2.5.x has -- only 2.5.x series
> specific code was removed/altered.
> 
> The driver itself really looks to be stable, it survived all the run
> tests, but if you have any problems running it, please, contact me or
> Anton.

Excellent work.  As I recall, the 2.5.x version is read-only.  Does 
this version have write support, or is it read only with this patch?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
