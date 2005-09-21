Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbVIUSfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbVIUSfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVIUSfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:35:39 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:51558 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751261AbVIUSfi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:35:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ghHnTegnNdtirxQGhcnkhrx6ntnuABf5ChlC7bM3MyGI1r7DWWkP/PgIjl9ILKGfXpbQzkDPNAI5ktE4CJQJO0rQ1gggY1iw12Uzf7rUfoZAKWauyLoOI0m/YE0XUM8laD5ivgJbtxl+ELX4P71aw6Q/1/hLSebQOZ4fM6SWFT0=
Date: Wed, 21 Sep 2005 20:35:05 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Alexander Nyberg <alexn@telia.com>
Cc: torvalds@osdl.org, pavel@suse.cz, akpm@osdl.org, ebiederm@xmission.com,
       len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050921203505.32cc714d.diegocg@gmail.com>
In-Reply-To: <20050921173630.GA2477@localhost.localdomain>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 21 Sep 2005 19:36:30 +0200,
Alexander Nyberg <alexn@telia.com> escribió:

> Morever bugme.osdl.org is severely underworked (acpi being a noteable
> exception) and Andrew has stepped in alot there too. Alot of bugs
> reported on the mailing list are only followed up by Andrew.

One of the things I'm _really_ missing from OSDL's bugzilla setup is a mailing
list (if there's one I've never heard about it) where all changes/new bugs/
random crap are posted. Something like:

http://lists.freedesktop.org/archives/xorg-bugzilla-noise/2005-April/thread.html
