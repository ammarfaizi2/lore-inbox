Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272884AbTG3Nx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 09:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272885AbTG3Nx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 09:53:27 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:61428 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272884AbTG3Nx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 09:53:26 -0400
Subject: Re: [PATCH repost] SHM to Sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01BF8C47@mesadm.epl.prov-liege.be>
References: <D9B4591FDBACD411B01E00508BB33C1B01BF8C47@mesadm.epl.prov-liege.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059572870.8052.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Jul 2003 14:47:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-30 at 08:27, Frederick, Fabian wrote:
> Alan,
> 
> The patch at the link below applies against 2.6.0.test2 and displays shm in
> sysfs.
> 
> http://fabian.unixtech.be/kernel/ipctosysfs.html
> 
> Could you apply ?

For 2.6.0-ac - no. I'm trying to collect stuff that is drivers, missing but 
clearly correct etc, not new stuff


