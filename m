Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270397AbTGMU4e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270404AbTGMU4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:56:34 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:28364 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S270397AbTGMU42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:56:28 -0400
Date: Sun, 13 Jul 2003 22:11:05 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ronald Bultje <rbultje@ronald.bitfreak.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.x] doesn't boot at all on one computer
Message-ID: <20030713211105.GA8661@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ronald Bultje <rbultje@ronald.bitfreak.net>,
	linux-kernel@vger.kernel.org
References: <1058115160.2200.7.camel@shrek.bitfreak.net> <20030713171523.GA28526@suse.de> <1058118821.2238.11.camel@shrek.bitfreak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058118821.2238.11.camel@shrek.bitfreak.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 07:53:41PM +0200, Ronald Bultje wrote:
 > >  > http://213.197.11.65/ronald/config-2.5.74-worksforothers
 > > Connection refused.
 > Whoops, local mess-up there. Fixed, sorry for that.

<randomguess>
Can you try with CONFIG_VIDEO_SELECT=n ?

		Dave

