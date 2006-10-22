Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWJVXqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWJVXqV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 19:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWJVXqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 19:46:21 -0400
Received: from triband-del-59.176.107.192.bol.net.in ([59.176.107.192]:53493
	"EHLO rootshell.ws") by vger.kernel.org with ESMTP id S1750743AbWJVXqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 19:46:20 -0400
Subject: Re: Moving to 2.6
From: "S.Mohideen" <moin@blackhole.labs.rootshell.ws>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0610222121330.22903@yvahk01.tjqt.qr>
References: <1161519502.1946.3.camel@libranet-box>
	 <1161522280.2035.0.camel@libranet-box>
	 <Pine.LNX.4.61.0610222121330.22903@yvahk01.tjqt.qr>
Content-Type: text/plain
Message-Id: <1161560758.2210.2.camel@libranet-box>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Oct 2006 05:15:58 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes !! The information i got was while doing make modules_install which
rescued me.

On Mon, 2006-10-23 at 00:52, Jan Engelhardt wrote:
> >Done !! It worked after installing new set modutils from kernel.org.
> 
> I am sure Documentation/ would have told you:
> 
> 
> 21:22 ichi:../linux/Documentation > grep module-init-t * -n
> Changes:35:o  module-init-tools      0.9.10                  # depmod -V
> Changes:115:A new module loader is now in the kernel that requires 
> module-init-tools
> 
> 
> 
> >Previously, I was receiving QM_MODULES errors..
> >
> 
> 	-`J'

