Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTIZNnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTIZNnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:43:15 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:61983 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262195AbTIZNnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:43:13 -0400
Date: Fri, 26 Sep 2003 09:43:02 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: s390 patches: descriptions.
Message-ID: <20030926094302.A6658@devserv.devel.redhat.com>
References: <OF50362BC7.7BE9F227-ONC1256DAD.00341C5E-C1256DAD.003461DB@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF50362BC7.7BE9F227-ONC1256DAD.00341C5E-C1256DAD.003461DB@de.ibm.com>; from schwidefsky@de.ibm.com on Fri, Sep 26, 2003 at 11:32:09AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 26, 2003 at 11:32:09AM +0200, Martin Schwidefsky wrote:
> The zfcp rework is going well but isn't quite finished yet.
> It's up to Heiko when he consideres the driver to be in state
> for inclusion into 2.6. For the zcrypt driver the news aren't
> so good. It very likely won't make it for 2.6.0.

What's wrong with current zcrypt from 2.4, aside from the
reading from urandom? It looked a relatively decent driver to me.

-- Pete
