Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751789AbWJVMae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbWJVMae (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 08:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWJVMae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 08:30:34 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:44976 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751789AbWJVMad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 08:30:33 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Freezer.h updated patch.
Date: Sun, 22 Oct 2006 14:29:33 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
References: <1161519286.3512.12.camel@nigel.suspend2.net>
In-Reply-To: <1161519286.3512.12.camel@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221429.33656.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 22 October 2006 14:14, Nigel Cunningham wrote:
> Hi guys.
> 
> I missed a couple of "#include <freezer.h>"s in yesterdays patch;
> funnily enough the ones in kernel/power! Here's an updated version.
> 
> Rafael, did you still think the freezer.h contents should go into
> suspend.h?

Yes.

> If so, I can redo a patch for that in the morning. I guess 
> the main advance over this will be a short patch (about 20 of the
> following files won't need patching).

Yes, please do it.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
