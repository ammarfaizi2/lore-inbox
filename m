Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273497AbRIUM5u>; Fri, 21 Sep 2001 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273500AbRIUM5k>; Fri, 21 Sep 2001 08:57:40 -0400
Received: from maild.telia.com ([194.22.190.101]:21984 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S273497AbRIUM5Z>;
	Fri, 21 Sep 2001 08:57:25 -0400
Date: Fri, 21 Sep 2001 15:01:47 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Lockups fixed! (Was: via82cxxx_audio locking problems)
Message-ID: <20010921150147.A254@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BA9AB43.C26366BF@scs.ch> <01092004333500.00182@c779218-a> <3BA9DBED.9020401@humboldt.co.uk> <01092005243800.01369@c779218-a> <20010920154049.A4282@telia.com> <3BAB080A.56DC7775@scs.ch> <20010921140613.A7758@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010921140613.A7758@telia.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I now tried this patch with 2.4.10-pre13 + VIA audio driver 1.1.15 and fixed
the stalls I used to see! I've only tested it for a few minutes so I can't
comment on any negative sideffects yet though.

Just a WFM.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
