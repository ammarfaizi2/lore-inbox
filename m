Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVBNAzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVBNAzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 19:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVBNAzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 19:55:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14527 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261321AbVBNAzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 19:55:36 -0500
Subject: Re: Oops with oprofile + RT preempt 2.6.11-rc2-RT-V0.7.37-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050213133020.GA16363@elte.hu>
References: <1108274835.3739.2.camel@krustophenia.net>
	 <20050213130058.GA566@zaniah>  <20050213133020.GA16363@elte.hu>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 19:55:35 -0500
Message-Id: <1108342535.25912.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-13 at 14:30 +0100, Ingo Molnar wrote:
> * Philippe Elie <phil.el@wanadoo.fr> wrote:
> 
> > oprofile_ops.cpu_type == NULL, this has been fixed 3 weeks ago, can
> > you retry with -rc4 ?
> 
> i've uploaded an -rc4 port of the -RT tree half an hour ago (-39-00).
> 

OK, I will test that.  FWIW I was running with PREEMPT_DESKTOP.

Maybe my CPU being a Cyrix III (VIA EPIA board) has something to do with
it.  I noticed that this CPU model is not mentioned on the oprofile web
site.

Lee

