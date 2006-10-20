Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946230AbWJTFGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946230AbWJTFGS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 01:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJTFGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 01:06:18 -0400
Received: from smtp-msa-out01.orange.fr ([193.252.23.120]:3989 "EHLO
	smtp-msa-out01.orange.fr") by vger.kernel.org with ESMTP
	id S1161444AbWJTFGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 01:06:17 -0400
X-ME-UUID: 20061020050614108.1A6B47000083@mwinf0114.orange.fr
X-ME-User-Auth: sven.luther
Date: Fri, 20 Oct 2006 07:02:47 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nicolas DET <nd@bplan-gmbh.de>, linuxppc-dev@ozlabs.org,
       Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
Message-ID: <20061020050247.GA11168@powerlinux.fr>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de> <1161308221.10524.92.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161308221.10524.92.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 11:37:01AM +1000, Benjamin Herrenschmidt wrote:
> On CHRP with only a 8259, make sure it's set as the default host.

Hi Ben,

Where you able to investigate the interupt tree or at least look over the
lsprop output we sent you ? 

Friendly,

Sven Luther

