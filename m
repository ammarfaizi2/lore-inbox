Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbREXLCd>; Thu, 24 May 2001 07:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbREXLCX>; Thu, 24 May 2001 07:02:23 -0400
Received: from t2.redhat.com ([199.183.24.243]:48369 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261357AbREXLCQ>; Thu, 24 May 2001 07:02:16 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <5.1.0.14.2.20010524114122.00aa7450@pop.cus.cam.ac.uk> 
In-Reply-To: <5.1.0.14.2.20010524114122.00aa7450@pop.cus.cam.ac.uk> 
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Blesson Paul <blessonpaul@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: How to add ntfs support 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 May 2001 12:01:40 +0100
Message-ID: <6917.990702100@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aia21@cam.ac.uk said:
> > I want to know , is there any method to register ntfs file system
> > without recompiling the whole kernel

> No, it is not possible to not recompile the kernel if NTFS was {not}
> configured. 

Is it not possible to build NTFS as a module?


--
dwmw2


