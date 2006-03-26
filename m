Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWCZXre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWCZXre (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWCZXre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:47:34 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:13760
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932217AbWCZXrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:47:33 -0500
Date: Sun, 26 Mar 2006 15:47:25 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [patch 00/10] PI-futex: -V1
Message-ID: <20060326234725.GA15203@gnuppy.monkey.org>
References: <20060326074535.GA9969@elte.hu> <Pine.LNX.4.44L0.0603261045230.32389-100000@lifa03.phys.au.dk> <20060326142539.GA26204@elte.hu> <20060326231000.GA14280@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326231000.GA14280@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 03:10:00PM -0800, Bill Huey wrote:
> On Sun, Mar 26, 2006 at 04:25:39PM +0200, Ingo Molnar wrote:
> 
> It's not quite as a simple as that. The use of a ceiling is a more aggressive
> method of controlling priority in an application. The use [of] it can control [-the-]
> thread preeemption, with regard to thread priority, [-primarily-] below the ceiling
> by prevent the occurance of priority inversion and the[re]for[e] the need for simple
> priority inheritance in the first place. It just simplifies what's going on in
> the app as wel[l] as what can happen [if priorities in an app are complex].

[with some grammar and spelling corrections]

Sorry, I think you folks get the idea, but typing a technical email just getting out of bed
without contacts is a bit challenging. :)
 
bill

