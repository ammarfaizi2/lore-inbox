Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267687AbTGTSsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 14:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267705AbTGTSsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 14:48:38 -0400
Received: from smtp-2.concepts.nl ([213.197.30.52]:3595 "EHLO
	smtp-2.concepts.nl") by vger.kernel.org with ESMTP id S267687AbTGTSsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 14:48:36 -0400
Subject: Re: [2.5.x] doesn't boot at all on one computer
From: Ronald Bultje <rbultje@ronald.bitfreak.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030713211105.GA8661@suse.de>
References: <1058115160.2200.7.camel@shrek.bitfreak.net>
	 <20030713171523.GA28526@suse.de>
	 <1058118821.2238.11.camel@shrek.bitfreak.net>
	 <20030713211105.GA8661@suse.de>
Content-Type: text/plain
Message-Id: <1058727848.2200.194.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 20 Jul 2003 21:04:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave & all,

On Sun, 2003-07-13 at 23:11, Dave Jones wrote:
> On Sun, Jul 13, 2003 at 07:53:41PM +0200, Ronald Bultje wrote:
>  > >  > http://213.197.11.65/ronald/config-2.5.74-worksforothers
[..]
> <randomguess>
> Can you try with CONFIG_VIDEO_SELECT=n ?

I had some time to test this today. Did I mention that you're a hero?
This fixed it, thanks!

Ronald

-- 
Ronald Bultje <rbultje@ronald.bitfreak.net>

