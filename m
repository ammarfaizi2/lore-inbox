Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWGLRyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWGLRyq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWGLRyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:54:46 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:32702 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932195AbWGLRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:54:45 -0400
Date: Wed, 12 Jul 2006 19:54:17 +0200
From: fork0@t-online.de (Alex Riesen)
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: Re: oops in bttv
Message-ID: <20060712175417.GA5939@steel.home>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mail-Followup-To: Alex Riesen <fork0@users.sourceforge.net>,
	Frederik Deweerdt <deweerdt@free.fr>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
References: <20060711204940.GA11497@steel.home> <20060712094416.GA1204@slug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712094416.GA1204@slug>
User-Agent: Mutt/1.5.6i
X-ID: bLYgW-ZYQeLpmwKyOf1QUCcvtSuCtB2IfRKRkA0YdTECLyzgOVNOrJ
X-TOI-MSGID: be33413e-dfd0-4183-b1cc-3f132a8761be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt, Wed, Jul 12, 2006 11:44:16 +0200:
> On Tue, Jul 11, 2006 at 10:49:40PM +0200, Alex Riesen wrote:
> > What I did was to call settings of the flashplayer and press on the
> > webcam symbol there. The system didn't crash, just this oops:
> > 
> > BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006
> > 5
> Does this happen every time you modprobe bttv ?

Yep.

