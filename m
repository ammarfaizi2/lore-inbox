Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267236AbUBRRoi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267639AbUBRRoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:44:38 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:3516 "EHLO
	falcon.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S267236AbUBRRoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:44:34 -0500
From: Eric <eric@cisu.net>
To: Zoltan NAGY <nagyz@nefty.hu>
Subject: Re: v2.6 in vmware?
Date: Wed, 18 Feb 2004 11:44:14 -0600
User-Agent: KMail/1.5.94
References: <634316431.20040218143725@nefty.hu>
In-Reply-To: <634316431.20040218143725@nefty.hu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402181144.14794.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 February 2004 7:37 am, Zoltan NAGY wrote:
> Hi!
>
> I've been trying to get 2.6.x working in vmware4, but it drops some
> oopses during init... I cannot provide details, but I'm sure that it
> does not just me who are having problems with it..

	Right now I am using Vmware 4.something in kernel 2.6.2-rc3 and will upgrade 
to 2.6.3 and im pretty sure it will work. Make sure you use the appropriate 
install script. Someone has published their own patches to make VMware more 
compatible w/ 2.6.
	Do a google for vmware-any-any-update49.tar.gz or updateXX where XX might be 
a newer version. I have not had any oopses with this package. The only 
problem I have is some older versions of the update package wouldnt compile. 
Perhaps you are insmodding a module built for 2.4 and crashing the kernel?

> Regards,
>
> --
> Zoltan NAGY,
> Network Administrator
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
