Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270380AbTG1SMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270383AbTG1SMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 14:12:44 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:64523 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S270380AbTG1SMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 14:12:43 -0400
Date: Mon, 28 Jul 2003 20:27:57 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test2: cursor started to disappear
Message-ID: <20030728182757.GA1793@win.tue.nl>
References: <20030728181408.GA499@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030728181408.GA499@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 08:14:08PM +0200, Pavel Machek wrote:

> Plus I'm seeing some silent data corruption. It may be
> swsusp or loop related

Loop is not stable at all. Unsuitable for daily use.

