Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268764AbUI2SGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268764AbUI2SGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 14:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUI2SGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 14:06:36 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:65260 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S268764AbUI2SGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 14:06:31 -0400
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: Lee Revell <rlrevell@joe-job.com>, Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: 2.6.9-rc2-mm4 and nvidia 1.0-6111
Date: Wed, 29 Sep 2004 19:07:12 +0100
User-Agent: KMail/1.7
References: <415A6EE6.1090404@blueyonder.co.uk> <20040929171522.GA18579@taniwha.stupidest.org> <1096478939.1600.3.camel@krustophenia.net>
In-Reply-To: <1096478939.1600.3.camel@krustophenia.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409291907.12821.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 18:28, you wrote:
> On Wed, 2004-09-29 at 13:15, Chris Wedgwood wrote:
> > On Wed, Sep 29, 2004 at 01:04:58PM -0400, Lee Revell wrote:
> > > Isn't there an nvidia-linux mailing list?  This is really OT for
> > > LKML.
> >
> > I had one for a while where I posted patches but it never gained much
> > momentum.  Unless there is a sizable group of people who want this I
> > don't see any need to resurrect it.
>
> OK, makes sense.  With so many people using the driver I guess it's just
> easiest to deal with nvidia problems on LKML.
>
> Lee
>

Just about any out-of-kernel driver using Changed-API-X will be broken, free 
or non-free. Something more general like linux-drivers or 
linux-kernel-drivers would probably make more sense.

Sometimes changes in -mm even break in-kernel drivers; it's not really an 
"NVIDIA problem" as such. I agree with Lee though; it's an unwritten rule 
that you prefix a subject with [OT] when speaking about something which isn't 
directly relevant to the kernel.

(By the way, if this breaks outside of -mm patches will appear for stable 
kernels on http://minion.de/ as did with the 2.5 development tree.)

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
