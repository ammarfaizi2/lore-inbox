Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVCBDYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVCBDYQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 22:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVCBDYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 22:24:16 -0500
Received: from orb.pobox.com ([207.8.226.5]:55447 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262153AbVCBDYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 22:24:12 -0500
Date: Tue, 1 Mar 2005 20:24:00 -0700
From: Paul Dickson <paul@permanentmail.com>
To: Baruch Even <baruch@ev-en.org>
Cc: dickson@permanentmail.com, linux-os@analogic.com,
       linux-kernel@vger.kernel.org
Subject: Re: Network speed Linux-2.6.10
Message-Id: <20050301202400.36259d94.paul@permanentmail.com>
In-Reply-To: <422510BA.1010305@ev-en.org>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
	<20050301175143.04cbbe64.dickson@permanentmail.com>
	<422510BA.1010305@ev-en.org>
X-Mailer: Sylpheed version 1.9.3 (GTK+ 2.4.14; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2005 01:02:50 +0000, Baruch Even wrote:

> > Might this be related to the broken BicTCP implementations in the 2.6.6+
> > kernels?  A fix was added around 2.6.11-rc3 or 4.
> 
> Unlikely, the problem with BIC would have shown itself only at high 
> speeds over long latency links, not over a lan connection.

I only mentioned the possibility because I saw the same profile given by
the PDF (the link was mentioned in the patch) while downloading gnoppix
via my cable modem.  The oscillations of speed varied from 40K to 500+K.
The average ended up around 270K.  (I was using wget for the download).

	-Paul

