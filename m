Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWBBRPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWBBRPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWBBRPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:15:18 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:49163 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932179AbWBBRPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:15:17 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: PROBLEM: kernel BUG at lib/kernel_lock.c:199!
Date: Thu, 2 Feb 2006 17:15:12 +0000
User-Agent: KMail/1.9.1
Cc: "Fabio d'Alessi" <cars@bio.unipd.it>, linux-kernel@vger.kernel.org
References: <43E2217B.9050404@bio.unipd.it> <9a8748490602020904m10d5a1e6h4e343ed7fbc71c87@mail.gmail.com>
In-Reply-To: <9a8748490602020904m10d5a1e6h4e343ed7fbc71c87@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602021715.12370.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 17:04, Jesper Juhl wrote:
> On 2/2/06, Fabio d'Alessi <cars@bio.unipd.it> wrote:
> > Dear sirs,
> > I have a problem with a dual athlon xp running fedora/4
> > with the 2.6.14-1 kernel. Hard locks. Please if anyone
>
> [...]
>
> > [7.1] standard fedora 4 install - nothing new added, just the
> > drivers for the nv graphic board.
>
> Adding the binary only nvidia module is not a little thing.
> That driver is a closed source binary blob that noone here has a
> chance to debug.

I suggest also if you want the kernel guys to help debug your problem, and not 
your distributor, that you upgrade to at least 2.6.15.2 and confirm the fault 
still exists.

Of course, Jesper is 100% correct about binary modules.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
