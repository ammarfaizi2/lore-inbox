Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUAUVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266101AbUAUVr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:47:56 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:61200 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S266119AbUAUVrw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:47:52 -0500
Date: Wed, 21 Jan 2004 22:50:12 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040121225012.1addb5c7.khali@linux-fr.org>
In-Reply-To: <10745567661358@kroah.com>
References: <10745567662012@kroah.com>
	<10745567661358@kroah.com>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also note that I slightly altered the condition to display the PCILynx
> comment. I think it's more logical that way. Without it, the user
> could get the message he/she needs I2C, go to enable it, come back and
> still not see the option.

For the records, please let it be noted that this change is *not* included
in the patch submitted by Greg.

That said, I still think it was a good idea. Not that it matters much to
me since I don't use that driver, but anyway... Who should I contact to
get it included?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
