Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270849AbRHXDv3>; Thu, 23 Aug 2001 23:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270855AbRHXDvT>; Thu, 23 Aug 2001 23:51:19 -0400
Received: from femail34.sdc1.sfba.home.com ([24.254.60.24]:4043 "EHLO
	femail34.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270849AbRHXDvG>; Thu, 23 Aug 2001 23:51:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Fred <fred@arkansaswebs.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
Date: Thu, 23 Aug 2001 20:50:40 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <E15a4Gz-0004uz-00@the-village.bc.nu> <01082322391300.12871@bits.linuxball>
In-Reply-To: <01082322391300.12871@bits.linuxball>
MIME-Version: 1.0
Message-Id: <01082320504000.00444@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 August 2001 08:39 pm, Fred wrote:
> /a5 directory above is /dev/hda5 a vfat partition (is this the
> problem?)

that's exactly the problem, FAT32 doesn't support files over 2GB
