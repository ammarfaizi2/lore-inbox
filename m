Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWEIMTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWEIMTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 08:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWEIMTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 08:19:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:25521 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932470AbWEIMTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 08:19:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
Date: Tue, 9 May 2006 14:18:55 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
References: <200605021200.37424.rjw@sisk.pl> <200605091219.17386.rjw@sisk.pl> <20060509112225.GA8816@elf.ucw.cz>
In-Reply-To: <20060509112225.GA8816@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605091418.56429.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 09 May 2006 13:22, Pavel Machek wrote:
> Hi!
> 
> > > EXTRA_PAGES is not a well-chosen identifier.  Please choose something
> > > within the swsusp "namespace", if there's such a thing.
> > 
> > Unfortunately there's not any, but I'll try to invent a better
> > name. :-)
> 
> PM_EXTRA_PAGES would probably be acceptable, as would
> SUSPEND_EXTRA_PAGES be...

Thanks, SUSPEND_EXTRA_PAGES sounds better to me.

Greetings,
Rafael
