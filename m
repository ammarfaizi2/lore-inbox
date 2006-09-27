Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030780AbWI0WXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbWI0WXu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 18:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031146AbWI0WXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 18:23:50 -0400
Received: from ozlabs.org ([203.10.76.45]:39568 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030780AbWI0WXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 18:23:49 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17690.63978.373862.727933@cargo.ozlabs.ibm.com>
Date: Thu, 28 Sep 2006 08:23:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, pmac@au1.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc1] ehea firmware interface based on Anton
	Blanchard's new hvcall interface
In-Reply-To: <451AF29D.2030102@garzik.org>
References: <200609271847.34258.ossthema@de.ibm.com>
	<451AF29D.2030102@garzik.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

> > This eHEA patch reflects changes according to Anton's new hvcall interface
> > which has been commited in Paul's git tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
> 
> When is this going upstream?  I don't want things to get too out-of-sync.

It's upstream already, and currently the ehea driver in Linus' tree
doesn't compile as a result.

Paul.
