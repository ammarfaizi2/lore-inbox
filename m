Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbVAZHG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbVAZHG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 02:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbVAZHG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 02:06:27 -0500
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:28174 "EHLO
	smtp-vbr12.xs4all.nl") by vger.kernel.org with ESMTP
	id S262371AbVAZHGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 02:06:24 -0500
Date: Wed, 26 Jan 2005 08:06:11 +0100
From: Jurriaan on adsl-gate <thunder7@xs4all.nl>
To: "sudhir@digitallink.com.np" <sudhir@digitallink.com.np>
Cc: linux-kernel@vger.kernel.org
Subject: Re: error while recompinling linux kernel
Message-ID: <20050126070611.GA12515@gates.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <48470-22005132664441773@M2W062.mail2web.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48470-22005132664441773@M2W062.mail2web.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 01:44:41AM -0500, sudhir@digitallink.com.np wrote:
> Hi,
> 
> I am a beginer in linux. I tried to recomplile kernel 2.4.9 and I
> encountered following error 
> 
> make[3]: *** [am79c961a.o] Error 1
> make[3]: Leaving directory `/usr/src/linux/drivers/net'
> make[2]: *** [first_rule] Error 2
> make[2]: Leaving directory `/usr/src/linux/drivers/net'
> make[1]: *** [_subdir_net] Error 2
> make[1]: Leaving directory `/usr/src/linux/drivers'
> make: *** [_dir_drivers] Error 2
> 
> can you someone help me please?
> 
The interesting line is just above the part you posted - the actual
error message. Also, 2.4.9 is ancient - current kernel is 2.4.29 IIRC.

Good luck,
Jurriaan
