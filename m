Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUH1WEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUH1WEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266351AbUH1WEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:04:52 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64425 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261724AbUH1WEu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:04:50 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux@horizon.com
Subject: Re: Summarizing the PWC driver questions/answers
Date: Sun, 29 Aug 2004 00:06:25 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@vger.kernel.org,
       paul@clubi.ie
References: <20040828210751.24380.qmail@science.horizon.com>
In-Reply-To: <20040828210751.24380.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408290006.25919.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 28. August 2004 23:07 schrieb linux@horizon.com:
> However, given that we already have access to lots of suitable Free
> interpolating software, Linux doesn't need that.  It just needs to know
> how to elicit a raw high-res frame from the camera and what the returned
> bits mean.  The rest can be coped with.

640 x 480 x 8 x 24 is still a lot more than USB 1.1 can handle.
What goes over the wire will be compressed.

	Regards
		Oliver
