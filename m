Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTI0FNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 01:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbTI0FNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 01:13:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:24324 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262375AbTI0FNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 01:13:18 -0400
Date: Sat, 27 Sep 2003 07:13:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@quark.didntduck.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] select CRC32
Message-ID: <20030927051315.GA968@mars.ravnborg.org>
Mail-Followup-To: Brian Gerst <bgerst@quark.didntduck.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <3F74C10B.4070606@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F74C10B.4070606@quark.didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 06:43:23PM -0400, Brian Gerst wrote:
> Use "select CRC32" in Kconfig instead of makefile includes.

Hi Brian - looks good to me.
I will apply it to my local tree if Linus does not take it.

	Sam
