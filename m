Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272546AbTGZO6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272545AbTGZO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:57:45 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:33154 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270153AbTGZOzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:55:42 -0400
Date: Sat, 26 Jul 2003 16:20:52 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307261520.h6QFKqDT002295@81-2-122-30.bradfords.org.uk>
To: rpjday@mindspring.com, szepe@pinerecords.com
Subject: Re: some kernel config menu suggested tweaks
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm merely thinking of turning your submenus into sub-entries
> in the main fs menu, because as John has pointed out, the submenus
> are rather annoying.

Having them as sub-entries would be an improvement all-round, (in my
opinion).

As well as improving the usability of make menuconfig, it's also
better for the make config configurator, because that decends in to
submenus automatically, whereas it prompts for sub-entries.

John.
