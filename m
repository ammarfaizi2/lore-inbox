Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWCTU1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWCTU1n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 15:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWCTU1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 15:27:43 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:12776 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030228AbWCTU1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 15:27:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: Announcing crypto suspend
Date: Mon, 20 Mar 2006 21:26:23 +0100
User-Agent: KMail/1.9.1
Cc: Peter Wainwright <prw@ceiriog.eclipse.co.uk>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20060320080439.GA4653@elf.ucw.cz> <200603201954.45572.rjw@sisk.pl> <441EFE54.2090004@gmail.com>
In-Reply-To: <441EFE54.2090004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603202126.23861.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 20 March 2006 20:11, Alon Bar-Lev wrote:
> Rafael J. Wysocki wrote:
> > and please read the HOWTO.  Unfortunately the RSA-related part hasn't been
> > documented yet, but it's pretty straightforward.
> 
> Hello,
> 
> I don't understand why you are working so hard on this... If
> you want encryption, you should care about all of your data!

I hope you realize there may be sensitive data in the suspend image
that are not stored in filesystems (eg. crypto keys, passwords etc.).

Greetings,
Rafael
