Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVL3UYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVL3UYI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 15:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbVL3UYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 15:24:07 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:5518 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932281AbVL3UYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 15:24:07 -0500
Message-ID: <43B5975B.3000004@tlinx.org>
Date: Fri, 30 Dec 2005 12:23:55 -0800
From: "Linda A. Walsh" <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en, en_US
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: patch for "scripts/package/buildtar" to pickup "localversion"
 on "/boot" file objects
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <43A7304B.2070103@tlinx.org> <20051219223030.GM13985@lug-owl.de> <43A762E0.5020608@tlinx.org> <43B4D4AC.5020303@tlinx.org> <20051230101527.GA18045@harddisk-recovery.com>
In-Reply-To: <20051230101527.GA18045@harddisk-recovery.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Erik Mouw wrote:

>A much easier way is to use:
>
>  version="${KERNELRELEASE}"
>
>A patch for this is already in -mm, I expect/hope Linus will pick it up
>after 2.6.15.
>  
>
---
Cool!  Easier is good! :-)
-linda

