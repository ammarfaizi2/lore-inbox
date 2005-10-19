Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbVJSEsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbVJSEsn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 00:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbVJSEsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 00:48:43 -0400
Received: from scooby.digital-creationsonline.com ([71.138.45.129]:42172 "EHLO
	scooby.digital-creationsonline.com") by vger.kernel.org with ESMTP
	id S1751507AbVJSEsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 00:48:43 -0400
From: "James E. Jennison" <james.jennison@digital-creationsonline.com>
Organization: Digital Creations Online
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: ImExPS/2 status
Date: Tue, 18 Oct 2005 21:48:37 -0700
User-Agent: KMail/1.8.2
References: <4Z9Qz-7an-5@gated-at.bofh.it> <4355C2F7.1080007@shaw.ca>
In-Reply-To: <4355C2F7.1080007@shaw.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200510182148.37822.james.jennison@digital-creationsonline.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert:
Yes, it does.  I have also tried manually specifying the mouse protocol to 
use, and that does not seem to help either.  Let me know if I can give you 
any other information.

-James

On Tuesday 18 October 2005 20:52, you wrote:
> James E. Jennison wrote:
> > Hey everyone...this is my first posting here, and I may not be going
> > about this the right way so please forgive me if I am not.  I had a
> > question regarding the status of the code for the ImExPS/2 style mice.
> >
> > I currently have a Nexxtech NXX200 PS/2 Optical Wheel Mouse, running
> > kernel 2.6.13.4.  I noticed that prior to the 2.6.x.x series (whilst in
> > the 2.4.x.x series (I was stubborn)), that my mouse was working fine.
> >
> > Now, however,if I plug my mouse in, the optical light comes on for
> > perhaps half a second, and the mouse goes dark.  The second thing that
> > happens is if you click either button, or move/click the scrollwheel, the
> > cursor will go to the upper right hand corner of the screen to where you
> > only see a small fraction of it.  This happens in both console mode and
> > in graphical.
>
> Does this also happen if the mouse is plugged in when powering up the
> machine? PS/2 devices are not really designed to be hot-plugged.
