Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSKNRa3>; Thu, 14 Nov 2002 12:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSKNRa3>; Thu, 14 Nov 2002 12:30:29 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:42756 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265169AbSKNRa2>;
	Thu, 14 Nov 2002 12:30:28 -0500
Date: Thu, 14 Nov 2002 18:36:58 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021114173658.GA10723@mars.ravnborg.org>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021113205844.GB2822@mars.ravnborg.org> <Pine.LNX.3.96.1021113180357.31924C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1021113180357.31924C-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2002 at 06:09:02PM -0500, Bill Davidsen wrote:
> > So mrproper and distclean behave in the same way.
> 
> So neither of them actually cleans the source tree to release a
> distribution anymore?
distclean aka mrproper these days cleans as much as it used to.
Let me know if you encounter something it fails to clean up, and I will
see to that it is fixed.

	Sam
