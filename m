Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSF0SWX>; Thu, 27 Jun 2002 14:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSF0SWW>; Thu, 27 Jun 2002 14:22:22 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:22032 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S316884AbSF0SWV>; Thu, 27 Jun 2002 14:22:21 -0400
Message-Id: <200206271820.g5RIKP913925@aslan.scsiguy.com>
To: "Gross, Mark" <mark.gross@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.24 and aic7xxx oopsing in ahc_linux_isr on system with LOTs of SCSI cards. 
In-Reply-To: Your message of "Thu, 27 Jun 2002 09:54:41 PDT."
             <59885C5E3098D511AD690002A5072D3C057B49F4@orsmsx111.jf.intel.com> 
Date: Thu, 27 Jun 2002 12:20:25 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a box with a LOT of SCSI adapters that isn't happy with 2.5 kernels,
>but is solid with the 2.4 kernels.

I have yet to review what's been done to the aic7xxx driver in 2.5.X.
I'm on paternity leave through July 8th, but when I return, updating the
driver port for 2.5.X is high on the list.

--
Justin
