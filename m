Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUI0LmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUI0LmM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 07:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUI0LmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 07:42:12 -0400
Received: from sa2.bezeqint.net ([192.115.104.16]:53385 "EHLO sa2.bezeqint.net")
	by vger.kernel.org with ESMTP id S266704AbUI0LmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 07:42:09 -0400
Date: Mon, 27 Sep 2004 14:43:21 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG: 2.6.9-rc2-bk11] input completely dead in X
Message-ID: <20040927124321.GC7486@luna.mooo.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040926210450.GA2960@luna.mooo.com> <20040926210045.GA15897@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040926210045.GA15897@thundrix.ch>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 11:00:45PM +0200, Tonnerre wrote:
> Salut,
> 
> On Sun, Sep 26, 2004 at 11:04:51PM +0200, Micha Feigin wrote:
> > Just tried kernel 2.6.9-rc2-bk11 and when I start X input is completely
> > dead (including num-lock, caps-lock, sysrq and mouse). The computer is
> > otherwise functional (I can log in with ssh, kill X and everything is
> > functional again).
> 
> Which X do you use? And which version?
> 

xfree 4.3 in debian unstable (I believe its somewhat modified), debian
calls it 4.3.0.dfsg.1-7.

The bk-input patch is a bit big for me to search for the problematic
change, but anyone has any leads I will happily poke around further.

> 			    Tonnerre


