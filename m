Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSIKHCb>; Wed, 11 Sep 2002 03:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSIKHCb>; Wed, 11 Sep 2002 03:02:31 -0400
Received: from angband.namesys.com ([212.16.7.85]:53898 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318428AbSIKHC1>; Wed, 11 Sep 2002 03:02:27 -0400
Date: Wed, 11 Sep 2002 11:07:09 +0400
From: Oleg Drokin <green@namesys.com>
To: Robert Love <rml@tech9.net>
Cc: Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911110709.A6193@namesys.com>
References: <Pine.LNX.4.44.0209102057340.944-100000@dad.molina> <1031716821.1571.91.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1031716821.1571.91.camel@phantasy>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Sep 11, 2002 at 12:00:20AM -0400, Robert Love wrote:

> >    BUG at kernel/sched.c        open                  10 Sep 2002
> What exactly is this?

Looks like this is my bugreport for BUG in kernel/sched.c:944 in the middle
of partition parsing output on boot.

Subject of email was
'2.5.34 BUG at kernel/sched.c:944 (partitions code related?)'
msgid: 20020910175639.A830@namesys.com

Bye,
    Oleg
