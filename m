Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbTJGCZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 22:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbTJGCZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 22:25:58 -0400
Received: from waste.org ([209.173.204.2]:39570 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261777AbTJGCZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 22:25:57 -0400
Date: Mon, 6 Oct 2003 21:25:51 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jesper Juhl <jju@dif.dk>, Matthias Andree <matthias.andree@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Message-ID: <20031007022551.GC5725@waste.org>
References: <20031006082340.GA1135@matchmail.com> <1065428996.5033.5.camel@laptop.fenrus.com> <20031006083803.GB1135@matchmail.com> <20031006102415.GB7598@merlin.emma.line.org> <Pine.LNX.4.56.0310061655070.26687@jju_lnx.backbone.dif.dk> <20031006174052.GA2190@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006174052.GA2190@matchmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 10:40:52AM -0700, Mike Fedyk wrote:
> 
> Looks good to me, but why is this config option arch specific?  Are there
> any archatectures that don't support DEBUG_INFO?

No, but most don't support kgdb.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
