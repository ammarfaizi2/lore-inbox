Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSFPVH1>; Sun, 16 Jun 2002 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSFPVH0>; Sun, 16 Jun 2002 17:07:26 -0400
Received: from adsl-216-62-201-136.dsl.austtx.swbell.net ([216.62.201.136]:21137
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316578AbSFPVHZ>; Sun, 16 Jun 2002 17:07:25 -0400
Subject: Re: Dual Athlon 2000 XP MP nightmare
From: Austin Gonyou <austin@digitalroadkill.net>
To: dmarkh@cfl.rr.com
Cc: Steve Cole <coles@vip.kos.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3D0C4CAF.578D7CC1@cfl.rr.com>
References: <003101c214bb$0275a720$0a00000a@kos.net>
	  <3D0C4CAF.578D7CC1@cfl.rr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 16 Jun 2002 16:06:33 -0500
Message-Id: <1024261593.18591.2.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 03:30, Mark Hounschell wrote:
...
> First make sure you have MP cpus NOT XP's. The XP's are not certified by amd to run
> SMP. Second, try append="mem=nopentium" in your lilo.conf file. I have a dual 1900+ MP
> box and without that I have random lockups also.
> 

Ahh..yes....sooo true. I thought that the subject was just
mis-represented, not necessarily wrong. I wholly agree on that. Also, if
you are using MPs, please try the KDB.
> Mark
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
