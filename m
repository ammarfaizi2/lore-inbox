Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWAFP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWAFP4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWAFP4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:56:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60164 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750721AbWAFP4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:56:08 -0500
Date: Fri, 6 Jan 2006 16:55:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nauman Tahir <nauman.tahir@gmail.com>
Cc: anil dahiya <ak_ait@yahoo.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: makefile for 2.6 kernel
Message-ID: <20060106155555.GD7953@mars.ravnborg.org>
References: <20060104182356.14925.qmail@web60217.mail.yahoo.com> <20060104185524.GA8296@mars.ravnborg.org> <f0309ff0601052320g76bea0afg61322551f57c6d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0309ff0601052320g76bea0afg61322551f57c6d38@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 11:20:29PM -0800, Nauman Tahir wrote:
 
> hi,
> Anil just put the names of your .c  files where I have mentioned. Hope
> this will work

Your Makefile try to stay compatible with 2.4 + 2.6.
And this includes a lot of extra stuff that can be removed for 2.6.

So only if the users wants to be compatible with both 2.4 AND 2.6 this
template is usefull.

	Sam
