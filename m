Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272675AbTHKNuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272676AbTHKNuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:50:11 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272675AbTHKNsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:48:55 -0400
Date: Mon, 11 Aug 2003 15:00:01 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308111400.h7BE01NL000208@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: Kconfig -- kill "if you want to read about modules, see" crap?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Each and every input driver (and other drivers are not better)
> contains this
>
> 	  This driver is also available as a module ( = code which can be
> 	  inserted in and removed from the running kernel whenever you want).
> 	  The module will be called input. If you want to compile it as a
> 	  module, say M here and read <file:Documentation/modules.txt>.
>
> text. Perhaps having 1000 copies of same help test is bad idea?

I totally agree.  The only part that's useful is 'The module will be
called...'.  We could change the whole wording to just, 'If compiled
as a module, it will be called...'.

John.
