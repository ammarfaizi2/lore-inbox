Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266075AbUAQQLI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUAQQLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:11:08 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:59300 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S266087AbUAQQLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:11:04 -0500
Subject: Re: No mouse wheel under 2.6.1 [Was: Re: Where are 2.6.x upgrade
	notes?]
From: Joaquim Fellmann <mljf@altern.org>
Reply-To: mljf@altern.org
To: Greg Stark <gsstark@mit.edu>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <873caj0y96.fsf_-_@stark.xeocode.com>
References: <87ptdocmf1.fsf@stark.xeocode.com>
	 <003801c3d9c4$2c2dead0$0e25fe0a@southpark.ae.poznan.pl>
	 <873caj0y96.fsf_-_@stark.xeocode.com>
Content-Type: text/plain
Message-Id: <1074352816.3838.2.camel@sid>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 17 Jan 2004 16:20:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 08:45, Greg Stark wrote:

> I'm using protocol MousemanPlusPS/2 with this logitech M-C48 mouse, which has
> always worked fine in the past. I just verified it still works fine under
> 2.4.23pre4 with the same version of X.
> 
> Does it work for anyone else?

I had the same problem. Switching protocol from MousemanPlusPS/2 to
ImPS2 in XF86Config-4 fixed it.

-- 
Joaquim

