Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbRHGPUt>; Tue, 7 Aug 2001 11:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268511AbRHGPUk>; Tue, 7 Aug 2001 11:20:40 -0400
Received: from acmey.gatech.edu ([130.207.165.23]:44693 "EHLO acmey.gatech.edu")
	by vger.kernel.org with ESMTP id <S268206AbRHGPUZ>;
	Tue, 7 Aug 2001 11:20:25 -0400
Message-Id: <5.1.0.14.2.20010807112251.00a8c440@pop.prism.gatech.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 07 Aug 2001 11:28:45 -0400
To: linux-kernel@vger.kernel.org
From: David Maynor <david.maynor@oit.gatech.edu>
Subject: encrypted swap
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>This is not about paranoia, this is about stolen notebooks.
>
>(And you can't easily add hundreds of megabytes to such systems
>usually.)

Then you can use a hardware token so that the machine will not boot at all 
with out it present or write an encrypted super block, but I can't really 
see the advantage of encrypted swap. At the point it would become 
effective, the attacker is already on the machine (from remote access or 
the have physical access) and then its not if you can keep them from 
getting the info, its only a matter of when.

