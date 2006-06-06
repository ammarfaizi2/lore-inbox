Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWFFVjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWFFVjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWFFVjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:39:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:206 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750956AbWFFVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:39:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IcUTdaqPEdMIjom9ljOpr024eFzsXuk3jdr1YSNfqMmLq5FngaNJUHWaMEzUnyrdkHMyq1y1fsYzETBkSOdSEsqru4gjsxXh3PkU6nvdL2QVybQT6zcOAo/bbQPWqY4PdNPYtB3DtvSMxOmJ0zBuPU9NKrMxBfGumiwsFvrOtHE=
Message-ID: <21d7e9970606061439m6e914bf8ya5567b672d5e14bb@mail.gmail.com>
Date: Wed, 7 Jun 2006 07:39:20 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44856223.9010606@gmail.com>
	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
	 <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
	 <4485DB6C.704@gmail.com>
	 <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> How is the stack maintained of what was previously bound to console?
> What if I unbind fbcon on a system that doesn't have VGAcon for a backup?

You could try actually reading the patches...

Dave.
