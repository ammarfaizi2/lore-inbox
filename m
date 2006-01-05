Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWAEHEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWAEHEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWAEHEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:04:36 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:30384 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751189AbWAEHEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:04:35 -0500
Date: Thu, 5 Jan 2006 08:03:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Andrew Morton <akpm@osdl.org>, Eric Dumazet <dada1@cosmosbay.com>,
       linux-kernel@vger.kernel.org, "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [2.6 patch] Define BITS_PER_BYTE
In-Reply-To: <20060104232442.GX3831@stusta.de>
Message-ID: <Pine.LNX.4.61.0601050802590.10161@yvahk01.tjqt.qr>
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com>
 <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com>
 <43BB1178.7020409@cosmosbay.com> <20060104034534.45d9c18a.akpm@osdl.org>
 <20060104232442.GX3831@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What about applying and using the patch below?
>
>cu
>Adrian
>
>This can make some arithmetic expressions clearer.
>
>+
>+#define BITS_PER_BYTE 8

Oh no :( This sounds as uncommon as CHAR_BIT in C.



Jan Engelhardt
-- 
