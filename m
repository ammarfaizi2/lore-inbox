Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbULBTsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbULBTsk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbULBTsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:48:40 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:62894 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261317AbULBTsi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:48:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=kDbapA4GlFXwyik71AX4iRL6hravA1qEPVEVnoDVEJWMK0JU8tyih8zc4EdANwE/E1eYySHG0TlGLmZyrXgg206IvvzRWJjU2dxJOfTYDWq5HlKgra33VbmBb/n2bsERjlUgQkl+i5Tw07r8hhz+aSJc9ZH7axQGpIGSfJd9x+Q=
Date: Thu, 2 Dec 2004 20:48:38 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and
 performance tests
Message-Id: <20041202204838.04f33a8c.diegocg@gmail.com>
In-Reply-To: <41AEBAB9.3050705@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	<Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	<Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	<41AEB44D.2040805@pobox.com>
	<20041201223441.3820fbc0.akpm@osdl.org>
	<41AEBAB9.3050705@pobox.com>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 02 Dec 2004 01:48:25 -0500 Jeff Garzik <jgarzik@pobox.com>
escribió:


> I'm still hoping that distros (like my employer) and orgs like OSDL will 
> step up, and hook 2.6.x BK snapshots into daily test harnesses.

Automated .deb's and .rpm's for the -bk snapshots (and yum/apt repositories)
would be nice for all those people who run unsupported distros.
