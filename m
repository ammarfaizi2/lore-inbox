Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317794AbSFMSsF>; Thu, 13 Jun 2002 14:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317796AbSFMSsF>; Thu, 13 Jun 2002 14:48:05 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:58267 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317794AbSFMSsD> convert rfc822-to-8bit; Thu, 13 Jun 2002 14:48:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-)
To: Greg KH <greg@kroah.com>
Subject: Re: USB Problems with 2.4.19-pre10-ac2
Date: Thu, 13 Jun 2002 20:50:03 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206131916.16214.knobi@knobisoft.de> <20020613173655.GD21644@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206132050.03835.knobi@knobisoft.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 June 2002 19:36, Greg KH wrote:
> On Thu, Jun 13, 2002 at 07:16:16PM +0200, Martin Knoblauch wrote:
> >  Suspicious are the "usb_control/bulk_msg: timeout" messages and the "not
> > accepting" stuff. Same happens with the uhci.o module. The camera works
> > with the 2.4.18-4GB kernel from SuSE8.0. So I suspect some problems with
> > 2.4.19-pre10-ac2. Unfortunatelly I cannot build 2.4.19-pre10 alone, due
> > to compilation errors.
>
> What compilation errors?  USB specific ones?
>

 The SIS framebuffer complaining about mtrr stuff. No USB.

> I would be very interested to see if this proble also happens on
> 2.4.19-pre10.
>

 After putting the SIS stuff away I could build -pre10. The problem happens 
there also :-(

Martin
-- 
----------------------------------
Martin Knoblauch
knobi@knobisoft.de
http://www.knobisoft.de
