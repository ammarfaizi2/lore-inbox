Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137188AbREKR0e>; Fri, 11 May 2001 13:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137190AbREKR0Q>; Fri, 11 May 2001 13:26:16 -0400
Received: from B12ef.pppool.de ([213.7.18.239]:29957 "EHLO susi.maya.org")
	by vger.kernel.org with ESMTP id <S137188AbREKRZ7>;
	Fri, 11 May 2001 13:25:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Hartmann <andihartmann@freenet.de>
Organization: Privat
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.4ac4] Kernel crash while unmounting CD: cause and solution
Date: Fri, 11 May 2001 19:24:54 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01051022310100.00484@athlon>
In-Reply-To: <01051022310100.00484@athlon>
MIME-Version: 1.0
Message-Id: <01051119245402.00434@athlon>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo all,

> [1.] One line summary of the problem:
>
> Kernel panic when trying to unmount a ide-scsi cdrom.

The problem was a not properly working cd-rw-device. I cleaned the optical 
lens - and the cd-rw-device is working like at the beginning of its days. 
With the same CD's which it doesn't want to burn and which causes the crash 
before!


Regards,
Andreas Hartmann
