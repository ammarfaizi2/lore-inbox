Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTEQSji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 14:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTEQSjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 14:39:37 -0400
Received: from angband.namesys.com ([212.16.7.85]:56961 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S261769AbTEQSjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 14:39:37 -0400
Date: Sat, 17 May 2003 22:52:22 +0400
From: Oleg Drokin <green@namesys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ch@murgatroid.com, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.69-mm6
Message-ID: <20030517185222.GA2716@namesys.com>
References: <200305162126_MC3-1-3947-176E@compuserve.com> <1053175888.7505.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053175888.7505.1.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sat, May 17, 2003 at 01:51:29PM +0100, Alan Cox wrote:
> >   What else should be disablable?
[...]
> swapping

This one is alreay disablable, I think.
At least my 2.5.69 from current bk have this
CONFIG_SWAP in "General setup" section of config ;)

Bya,
    Oleg
