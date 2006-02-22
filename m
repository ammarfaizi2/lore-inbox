Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWBVKte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWBVKte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 05:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWBVKtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 05:49:33 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:895 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750744AbWBVKtd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 05:49:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=EQQkhycllN+9fOP/drxnFfLdSKsfkeT+FaZofpycp5SipAj6+qsl7oNL7dEzbBqMbxjEdioWgGWZZxmDuH7WA9+yUa0cUfTKPIJvUlJZ5G/BiFjM2EUIP8H3I9FT6BmtBtnthR9O5WmT0opWwXhQD+geY7XAvKZ4arXf0b13PsI=
Date: Wed, 22 Feb 2006 11:49:19 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Kay Sievers <kay.sievers@suse.de>
Cc: akpm@osdl.org, penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de,
       rml@novell.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060222114919.a58fbbea.diegocg@gmail.com>
In-Reply-To: <20060222000429.GB12480@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	<20060217231444.GM4422@stusta.de>
	<84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	<20060219145442.GA4971@stusta.de>
	<1140383653.11403.8.camel@localhost>
	<20060220010205.GB22738@suse.de>
	<1140562261.11278.6.camel@localhost>
	<20060221225718.GA12480@vrfy.org>
	<20060221153305.5d0b123f.akpm@osdl.org>
	<20060222000429.GB12480@vrfy.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 22 Feb 2006 01:04:29 +0100,
Kay Sievers <kay.sievers@suse.de> escribió:

> HAL was prepared to make use of the new events and needs to be upgraded
> when the kernel gets upgraded. This happens all the time as long as we

I noticed there is not a hal entry in Documentation/Changes, if hal
really depends on the kernel (it does?) maybe it should be added there.
