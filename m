Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVGHSMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVGHSMc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVGHSMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:12:32 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:49887 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262749AbVGHSMa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:12:30 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Fri, 8 Jul 2005 19:12:36 +0100
User-Agent: KMail/1.8.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507081842.53089.s0348365@sms.ed.ac.uk> <20050708174815.GA4884@devserv.devel.redhat.com>
In-Reply-To: <20050708174815.GA4884@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507081912.36827.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 Jul 2005 18:48, Jakub Jelinek wrote:
> On Fri, Jul 08, 2005 at 06:42:53PM +0100, Alistair John Strachan wrote:
> > > btw., which gcc version are you using?
> >
> > Not the GCC version known to bloat stacks ;-)
> >
> > 3.4.4, on both my machines. I'm not touching 4.x until 4.0.1 is released
> > with the miscompiled-code fixes.
>
> GCC 4.0.x bloats stacks less than 3.4.4.
> And, if you are looking for 4.0.1, it has been released yesterday.
>

Thanks for the info, great. However, I'm sure it would be good if a "known 
good" GCC prior to 4.0.x was usable on a 4KSTACKS/RT-PREEMPT kernel?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
