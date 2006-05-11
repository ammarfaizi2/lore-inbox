Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbWEKATi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbWEKATi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWEKATi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:19:38 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:53770 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S965105AbWEKATh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:19:37 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Stability of 2.6.17-rc3?
Date: Thu, 11 May 2006 01:19:46 +0100
User-Agent: KMail/1.9.1
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Joshua Hudson <joshudson@gmail.com>,
       linux-kernel@vger.kernel.org
References: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com> <200605101041.14595.s0348365@sms.ed.ac.uk> <Pine.LNX.4.61.0605110022040.5869@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605110022040.5869@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605110119.46822.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 23:23, Jan Engelhardt wrote:
> >Though, Joshua, 2.6.17-rc3 seems to be a rock-solid release. It's safe
> > enough to diff against and boot, if that's what you want to do.
>
> It did not eat the virtual machine so its chances are good. However, I wait
> for 2.6.17 because of the few XFS fixes gone in since then.

I run a 1TB XFS filesystem on a RAID5 with no ill-effects. I've never 
experienced data-loss in 2.6, mostly due to conservative options (no 4k 
stacks, no regparm, XFS only).

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
