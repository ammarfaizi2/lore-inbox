Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTFOLYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 07:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTFOLY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 07:24:29 -0400
Received: from smtp.terra.es ([213.4.129.129]:12441 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S262153AbTFOLY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 07:24:28 -0400
Date: Sun, 15 Jun 2003 13:22:21 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-mm9
Message-Id: <20030615132221.0b481b95.diegocg@teleline.es>
In-Reply-To: <1055663908.631.0.camel@teapot.felipe-alfaro.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<20030615031421.1ed6640a.diegocg@teleline.es>
	<1055663908.631.0.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jun 2003 09:58:29 +0200
Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> The "__mark_inode_dirty" message is a deugging leftofer from Andrew that
> is spit out the first time the machine starts swapping out. You can
> safely ignore it.
> 

Happy to hear that :)
It happened in the init scripts, so it seems coherent.
Anyway, i rebooted to fsck the root filesystem and it found a error (i
don't remember what though) and it fixed it. 
