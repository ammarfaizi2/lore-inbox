Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbUL0UJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUL0UJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 15:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUL0UJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 15:09:19 -0500
Received: from manson.clss.net ([65.211.158.2]:36050 "HELO manson.clss.net")
	by vger.kernel.org with SMTP id S261965AbUL0UJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 15:09:05 -0500
Message-ID: <20041227200901.23134.qmail@manson.clss.net>
From: "Alan Curry" <pacman-kernel@manson.clss.net>
Subject: Re: Module Names - Hyphen Converted to Underscore
To: linux-kernel@vger.kernel.org
Date: Mon, 27 Dec 2004 15:09:01 -0500 (EST)
In-Reply-To: <1104177282.5683.2.camel@localhost.localdomain> from "Tomasz Torcz" at Dec 27, 2004 08:54:42 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz writes the following:
>
> modprobe intelligently adds or removes a module from the Linux kernel:
>note  that  for  convenience,there  is  no  difference  between  _  and
>- in module names. 

What definition of convenience led to this?

In that spirit, should fs now interpret backslash as a directory separator?
Having to remember the difference is SO inconvenient.

