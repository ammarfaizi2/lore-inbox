Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSGTM31>; Sat, 20 Jul 2002 08:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGTM31>; Sat, 20 Jul 2002 08:29:27 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:52915 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S316608AbSGTM31> convert rfc822-to-8bit; Sat, 20 Jul 2002 08:29:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH]: scheduler complex macros fixes
Date: Sat, 20 Jul 2002 14:32:11 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>,
       Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0207201937330.18265-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207201937330.18265-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207201432.11496.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Saturday 20 July 2002 19:43, Ingo Molnar wrote:
> On Fri, 19 Jul 2002, Linus Torvalds wrote:
> > So I'd rather have the non-batch stuff done first and independently.
>
> sure - all the non-batch bits are attached, against 2.5.26-vanilla. It
> compiles & boots just fine on UP & SMP as well.
>
>         Ingo

thanks for the complete update without the SCHED_BATCH! I was too lazy
to strip out all your changes and I'm sure I would have made mistakes...

Best regards,
Erich

