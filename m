Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTKMVhv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 16:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTKMVhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 16:37:50 -0500
Received: from linux.us.dell.com ([143.166.224.162]:34467 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264426AbTKMVhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 16:37:50 -0500
Date: Thu, 13 Nov 2003 15:35:52 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jason Holmes <jholmes@psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.6 megaraid recognize intel vendor id
Message-ID: <20031113153552.A20514@lists.us.dell.com>
References: <3FB3BBE0.D4D0EACC@psu.edu> <3FB3D5B1.5080904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FB3D5B1.5080904@pobox.com>; from jgarzik@pobox.com on Thu, Nov 13, 2003 at 02:04:17PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ewwww.
> 
> I don't object to your patch, but I'm disappointed that megaraid doesn't 
> use the normal PCI probing mechanism.

It's on their TODO list I know.  I've been pushing for that too.

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
