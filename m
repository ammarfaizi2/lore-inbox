Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTLKJ3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 04:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264604AbTLKJ3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 04:29:53 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:55963
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264601AbTLKJ3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 04:29:52 -0500
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Thu, 11 Dec 2003 10:29:50 +0100
User-Agent: KMail/1.5.4
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <3FD64BD9.1010803@pacbell.net> <200312110949.54929.baldrick@free.fr> <20031211092311.GB5102@kroah.com>
In-Reply-To: <20031211092311.GB5102@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312111029.50138.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If the file is open, keep the reference count.  If you were to try
> anything else, it would just be to complex in the end.
>
> It's ok to wait a long time on rmmod, that's a pretty unique situation.

Great - thanks.

Duncan.
