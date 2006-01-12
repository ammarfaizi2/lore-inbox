Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWALQQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWALQQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWALQQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:16:05 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:9652 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1030456AbWALQQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:16:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC: -mm patch] swsusp: make some code static
Date: Thu, 12 Jan 2006 17:18:08 +0100
User-Agent: KMail/1.9
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pm@osdl.org
References: <20060111042135.24faf878.akpm@osdl.org> <20060112104812.GR29663@stusta.de> <20060112152935.GD9752@elf.ucw.cz>
In-Reply-To: <20060112152935.GD9752@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601121718.08959.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 12 January 2006 16:29, you wrote:
> On Čt 12-01-06 11:48:12, Adrian Bunk wrote:
> > On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
> > >...
> > > Changes since 2.6.15-mm2:
> > >...
> > > +swsusp-low-level-interface-rev-2.patch
> > >...
> > >  swsusp updates
> > >...
> > 
> > After this patch, we can make some code static.

Nice catch. ;-)

> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> Rafael should comment here. It is okay, but Rafael has some patches in
> the queue, and it would be better if there were to clashes.

It doesn't clash with any of my patches (just tested).

Greetings,
Rafael
