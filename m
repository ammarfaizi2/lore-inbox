Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWAQRjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWAQRjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWAQRjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:39:17 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:34061 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932205AbWAQRjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:39:16 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Michael Krufky <mkrufky@m1k.net>
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
Date: Tue, 17 Jan 2006 17:39:17 +0000
User-Agent: KMail/1.9
Cc: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
References: <43CCF8BB.1050009@m1k.net>
In-Reply-To: <43CCF8BB.1050009@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171739.17168.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 14:01, Michael Krufky wrote:
> To Whom (and ALL) that it may concern:
>
> For the past week or so, I haven't been able to get gitweb, running on
> kernel.org, to show me any diff's.
>
> For each commit, if I click on the "commit" link, or "commitdiff" link,
> the best I get is something that looks like this:
>
> file:fd8bc718f0e33df0a446d3d5c67f68929eca6490
> <http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blo
>b;h=fd8bc718f0e33df0a446d3d5c67f68929eca6490;hb=e0ad8486266c3415ab9c17f5c03c
>47edc7b93d7b;f=drivers/media/video/cx88/cx88-alsa.c> ->
> file:e649f678d47ab0a749b89146867ff9b1f513f73a
> <http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blo
>b;h=e649f678d47ab0a749b89146867ff9b1f513f73a;hb=e0ad8486266c3415ab9c17f5c03c
>47edc7b93d7b;f=drivers/media/video/cx88/cx88-alsa.c>
>
> This is for "V4L/DVB (3375): git dvb callbacks fix" , but it happens for
> every patch I try to view...  Even if I try to view the patch in "plan"
> mode, the following is all that I can see:
>
> From: Andrew Morton <akpm@osdl.org>
> Date: Sun, 15 Jan 2006 08:45:20 +0000 (-0200)
> Subject: V4L/DVB (3375): git dvb callbacks fix
> X-Git-Tag: v2.6.16-rc1
> X-Git-Url:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>itdiff;h=e0ad8486266c3415ab9c17f5c03c47edc7b93d7b
>
> V4L/DVB (3375): git dvb callbacks fix
>
> - Not sure what went wrong here, but SND_PCI_PM_CALLBACKS got deleted.
>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
> ---
>
> (I havent seen this patch, and I'm really curious what happens in it,
> and the explanation of the commit message -- these questions are
> probably answered simply by viewing the patch, which I cant do :-(  )
>
> ... I have tried this at multiple locations, using several different
> browsers under different OS's ... It won't show me a diff no matter what
> I do, and it USED to work (about a week ago)
>
> I'm surprised nobody has complained about this already.  (or maybe I
> just didnt see any such thread about it)

Seems to work for me right _now_, could you verify that this is still 
happening?

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
