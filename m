Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262356AbSJOEd4>; Tue, 15 Oct 2002 00:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262357AbSJOEd4>; Tue, 15 Oct 2002 00:33:56 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:56680
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S262356AbSJOEdz>; Tue, 15 Oct 2002 00:33:55 -0400
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not
	suspend devices
From: Eric Blade <eblade@blackmagik.dynup.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m13cr9kpjo.fsf@frodo.biederman.org>
References: <200210132359.QAA01092@adam.yggdrasil.com>
	<m1of9xlw7g.fsf@frodo.biederman.org> <1034573925.2786.55.camel@cpq> 
	<m13cr9kpjo.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 15 Oct 2002 00:34:14 -0400
Message-Id: <1034656454.2786.117.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 11:28, Eric W. Biederman wrote:
> 
> SUSPEND_POWER_DOWN as defined should actually cause the behavior Adam
> was seeing.  Which made it doubly interesting.
> 
> Will you submit a patch detangling this mess?  I believe Adams
> only problem was that it did not obviously fix his problem.
> 

Submitted earlier last night. 

 subj: Patch: linux-2.5.42/drivers/base/power.c - add state for
SHUT_DOWN

 Cheers,
  - Eric




