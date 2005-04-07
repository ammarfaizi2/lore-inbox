Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbVDGPFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVDGPFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVDGPFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:05:07 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:15187 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262476AbVDGPFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:05:02 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Greg KH <greg@kroah.com>
Subject: Re: [stable] [patch 1/1] uml: quick fix syscall table [urgent]
Date: Thu, 7 Apr 2005 17:11:15 +0200
User-Agent: KMail/1.7.2
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org
References: <20050406183802.48AF7C5D4E@zion> <20050406202109.GA31699@kroah.com>
In-Reply-To: <20050406202109.GA31699@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071711.15669.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 22:21, Greg KH wrote:
> On Wed, Apr 06, 2005 at 08:38:00PM +0200, blaisorblade@yahoo.it wrote:
> > CC: <stable@kernel.org>
> >
> > I'm resending this for inclusion in the -stable tree. I've deleted
> > whitespace cleanups, and hope this can be merged. I've been asked to
> > split the former patch, I don't know if I must split again this one, even
> > because I don't want to split this correct patch into multiple
> > non-correct ones by mistake.
>
> Is this patch already in 2.6.12-rc2?
Yes, with whitespace cleanups.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

