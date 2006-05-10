Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWEJJr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWEJJr5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWEJJr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:47:57 -0400
Received: from smtp.bulldogdsl.com ([212.158.248.7]:10760 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964881AbWEJJr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:47:56 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Stability of 2.6.17-rc3?
Date: Wed, 10 May 2006 10:41:14 +0100
User-Agent: KMail/1.9.1
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Joshua Hudson <joshudson@gmail.com>,
       linux-kernel@vger.kernel.org
References: <bda6d13a0605091340x2e16342v15733b2c9612d985@mail.gmail.com> <9a8748490605091501r4bcff8b0q630cbf2fa0e33732@mail.gmail.com> <Pine.LNX.4.61.0605100931250.27657@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0605100931250.27657@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605101041.14595.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 May 2006 08:34, Jan Engelhardt wrote:
> > 2.6.17-rc3 is a development kernel, no guarantees about anything really.
> > Development kernels are run completely at your own risk. It may run
> > fine, it may explode at boot, [...], it may eat your lunch, it may cause
> > an alien invasion -[...]
>
> Quite a list. So what can -mm kernels make go wrong more? :-]

Well, back in the 2.5 days, JFS/-mm ate my filesystem, which is possibly worse 
than it eating my lunch, and more relevant to me than an alien invasion...

Though, Joshua, 2.6.17-rc3 seems to be a rock-solid release. It's safe enough 
to diff against and boot, if that's what you want to do.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
