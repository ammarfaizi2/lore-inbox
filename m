Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUCEVWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbUCEVWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:22:45 -0500
Received: from h24-78-210-69.ss.shawcable.net ([24.78.210.69]:63754 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S262109AbUCEVWm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:22:42 -0500
Date: Fri, 5 Mar 2004 15:26:30 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
Message-ID: <20040305212630.GB22261@discworld.dyndns.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040304100503.GA13970@havoc.gtf.org> <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp> <c2ambg$9rs$1@terminus.zytor.com> <4048EA87.1080304@matchmail.com> <4048EADF.1060601@zytor.com> <yw1xsmgnc7sw.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xsmgnc7sw.fsf@kth.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård <mru@kth.se> wrote:
> >
> > Right now, "less" seems to insist on showing ampersands for *any*
> > non-ASCII character for me...
> 
> Less version 381 is working fine here with UTF-8.  I have LANG and
> LC_CTYPE set to en_US.UTF-8.

less 340 works fine here with the same settings.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
