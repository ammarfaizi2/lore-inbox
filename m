Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVFCSja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVFCSja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFCSja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:39:30 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:55947 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261477AbVFCSjZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:39:25 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ananda Krishnan <veedutwo@yahoo.com>
Subject: Re: Did anyone try (Logitech/Microsoft) bluetooth keyboard and mouse on Linux?
Date: Fri, 3 Jun 2005 19:39:34 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050602163740.37068.qmail@web14824.mail.yahoo.com>
In-Reply-To: <20050602163740.37068.qmail@web14824.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506031939.34724.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 Jun 2005 17:37, Ananda Krishnan wrote:
> Hi,
>
>   Did anyone try Logitech/Microsoft wireless keyboard
> and mouse on Linux?  If so, please let me have the
> details of the driver you used and the details of the
> keyboard/mouse (model number, brand etc.,).  Thanks.
>

Ananda,

These devices should work fine with the standard drivers.

Make sure you configure your X server for the keyboard's extended protocol 
(mine is "microsoftinet", most Logitech keyboards are compatible with this). 
This will allow you (automatically) to use the extended access keys. KDE 
certainly supports this automatically, I have no doubt GNOME does too (at 
least!).

Your mouse's buttons should all be mappable with the standard "ExplorerPS/2" 
or "usb" mouse protocols in X. Like the windows drivers, you can configure 
special buttons or keys to perform just about any task you like.

I hope this helps.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
