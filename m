Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTEFJRB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262483AbTEFJRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:17:01 -0400
Received: from AMontpellier-205-2-1-77.abo.wanadoo.fr ([193.252.48.77]:10489
	"EHLO tethys.montpellier.4js.com") by vger.kernel.org with ESMTP
	id S262465AbTEFJRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:17:00 -0400
Date: Tue, 6 May 2003 11:29:28 +0200
From: wwp <subscript@free.fr>
To: Hans-Georg Thien <1682-600@onlinehome.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh
 a PS/2 Trackpad
Message-Id: <20030506112928.60306baf.subscript@free.fr>
In-Reply-To: <3EB19625.6040904@onlinehome.de>
References: <3EB19625.6040904@onlinehome.de>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans-Georg Thien,


On Thu, 01 May 2003 23:48:21 +0200 Hans-Georg Thien <1682-600@onlinehome.de>
wrote:

> Sorry for this long text and my bad english. And please be kind to me -
> it is my very first posting to this mailing list ...
> 
> I have written a *very small* patch against the linux 2.4.20 kernel and
> I want to submit it now.

Would it be possible to enable/disable this feature from userspace using an
echo 1 > /proc/blabla, or only using insmod/modprobe -r?
Anyway, very good idea!


Regards,

-- 
wwp
