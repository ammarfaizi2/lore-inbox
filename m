Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVLOWRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVLOWRE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVLOWRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:17:03 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28627 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750986AbVLOWRB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:17:01 -0500
Subject: Re: SATA feature list available
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Velu Erwan <erwan@seanodes.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
In-Reply-To: <43A1AEA7.60101@seanodes.com>
References: <43A1A37E.4070806@pobox.com>
	 <1134669106.12421.67.camel@localhost.localdomain>
	 <43A1AEA7.60101@seanodes.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 15 Dec 2005 22:16:59 +0000
Message-Id: <1134685019.20495.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-15 at 18:57 +0100, Velu Erwan wrote:
> Alan Cox a écrit :
> 
> >ATIIXP
> >  
> >
> Did your patch includes a patch for ATIIXP to solve the troubles we 
> tried to fix with bruno ?

No. I'd actually expect libata to handle that internally as its drive
level, but I'm not sure it does. Added to the 'to investigate' list.

