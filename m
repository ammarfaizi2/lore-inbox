Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291294AbSAaVDW>; Thu, 31 Jan 2002 16:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291301AbSAaVDE>; Thu, 31 Jan 2002 16:03:04 -0500
Received: from mailhost.terra.es ([195.235.113.151]:42046 "EHLO
	tsmtp4.mail.isp") by vger.kernel.org with ESMTP id <S291294AbSAaVCx>;
	Thu, 31 Jan 2002 16:02:53 -0500
From: "Diego Calleja" <grundig@teleline.es>
To: Zwane Mwaikambo <zwane@commfireservices.com>,
        "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
Date: jue, 31 ene 2002 22:03:40 +0000
In-Reply-To: <Pine.LNX.4.44.0201301213300.2730-100000@netfinity.realnet.co.sz>
X-Mailer: Pyne 0.6.7 (Debian/GNU/Linux)
Content-Type: text/plain
MIME-Version: 1.0
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        lkml <linux-kernel@vger.kernel.org>
Message-Id: <20020131210253Z291294-13996+15243@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you try reproduce the font corruption with CONFIG_MTRR disabled, just 
> for my amusement. I would greatly appreciate it.
> 
> Cheers,
> 	Zwane Mwaikambo
I can reproduce it whith CONFIG_MTRR disabled. It happens again.
