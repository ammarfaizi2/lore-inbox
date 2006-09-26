Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWIZRUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWIZRUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWIZRUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:20:46 -0400
Received: from [81.2.110.250] ([81.2.110.250]:12524 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932164AbWIZRUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:20:45 -0400
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add
	pmops->{prepare,enter,finish} support (aka "platform mode"))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Stefan Seyfried <seife@suse.de>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <1159289108.9652.10.camel@chalcedony.pathscale.com>
References: <20060925071338.GD9869@suse.de>
	 <1159220043.12814.30.camel@nigel.suspend2.net>
	 <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz>
	 <20060925160648.de96b6fa.akpm@osdl.org>  <20060925232151.GA1896@elf.ucw.cz>
	 <1159289108.9652.10.camel@chalcedony.pathscale.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Sep 2006 18:44:06 +0100
Message-Id: <1159292646.11049.273.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-09-26 am 09:45 -0700, ysgrifennodd Bryan O'Sullivan:
> 16 seconds doing things to devices

Flushing the cache of a busy disk is 7 seconds a disk just to begin
with.


