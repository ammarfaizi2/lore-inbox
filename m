Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316456AbSGSO1T>; Fri, 19 Jul 2002 10:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318527AbSGSO1T>; Fri, 19 Jul 2002 10:27:19 -0400
Received: from hoemail1.lucent.com ([192.11.226.161]:12703 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S316456AbSGSO1P>; Fri, 19 Jul 2002 10:27:15 -0400
From: stoffel@lucent.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15672.8817.304792.714541@gargle.gargle.HOWL>
Date: Fri, 19 Jul 2002 10:30:09 -0400
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.26 : drivers/scsi/BusLogic.c
In-Reply-To: <20020718192413.A28163@redhat.com>
References: <200207181700.g6IH03U02415@localhost.localdomain>
	<20020718192413.A28163@redhat.com>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Doug> There are.  I'm currently writing a patch (hopefully a first
Doug> test version will be out in an hour or so).  It's not quite as
Doug> easy as it looks at first mainly because this driver supports
Doug> PCI, EISA, VLB, MCA, and ISA cards :-/

I've got a PCI BusLogic SCSI card at home I've been unable to use for
a while on 2.4, so I'm really interested in this patch.  

Maybe it's time to break out old the EISA, VLB, MCA and ISA support
into their own modules/sections?  I think the PCI version will be the
most in demand. 

Thanks though for your work!

John
