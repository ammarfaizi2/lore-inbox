Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264256AbUEXLpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUEXLpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 07:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUEXLpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 07:45:44 -0400
Received: from ktown.kde.org ([131.246.103.200]:8625 "HELO ktown.kde.org")
	by vger.kernel.org with SMTP id S264254AbUEXLpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 07:45:43 -0400
Date: Mon, 24 May 2004 13:45:41 +0200
From: Oswald Buddenhagen <ossi@kde.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
Message-ID: <20040524114541.GA869@ugly.local>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040523154859.GC22399@dumbterm.net> <20040524092057.GA26715@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524092057.GA26715@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 11:20:57AM +0200, Ingo Molnar wrote:
> * Billy Biggs <vektor@dumbterm.net> wrote:
> >   The theory is that Linux classifies this as a CPU hog regardless of
> > its priority, and preempts tvtime with other processes. [...]
> 
> this would indicate a pretty broken scheduler. To prove (or exclude)
> this possibility, could you apply the attached debugging patch?
>
done. no messages in the kernel syslog.

greetings

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Chaos, panic, and disorder - my work here is done.
