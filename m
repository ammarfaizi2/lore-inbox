Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWDCMNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWDCMNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWDCMNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:13:18 -0400
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:61323 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751443AbWDCMNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:13:18 -0400
Date: Mon, 3 Apr 2006 14:13:15 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: Al Boldi <a1426z@gawab.com>
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.3.1 for  2.6.16-rc5
Message-ID: <20060403141315.5a95497b@localhost>
In-Reply-To: <200604031459.51542.a1426z@gawab.com>
References: <200604031459.51542.a1426z@gawab.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2006 14:59:51 +0300
Al Boldi <a1426z@gawab.com> wrote:

> > >> You can select a default scheduler at kernel build time.  If you wish
> > >> to boot with a scheduler other than the default it can be selected at
> > >> boot time by adding:
> > >>
> > >> cpusched=<scheduler>
> 
> Can this be made runtime selectable/loadable, akin to iosched?

There is a project to do so:

http://groups.google.com/group/fa.linux.kernel/msg/d555ecee596690d1

-- 
	Paolo Ornati
	Linux 2.6.16-mm2 on x86_64
