Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbTAYC0f>; Fri, 24 Jan 2003 21:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbTAYC0f>; Fri, 24 Jan 2003 21:26:35 -0500
Received: from as4-1-7.has.s.bonet.se ([217.215.31.238]:41887 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id <S266078AbTAYC0e>;
	Fri, 24 Jan 2003 21:26:34 -0500
Message-ID: <3E31F7B0.7090606@stesmi.com>
Date: Sat, 25 Jan 2003 03:34:24 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BIOS setup needed for LBA48?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Let's assume a certain IDE controller does LBA48.

Let's at the same time assume the BIOS doesn't know jack
about LBA48.

Let's then assume that I can get a kernel to boot on it,
what method I use doesn't matter. The BIOS doesn't lock up
or anything but it doesn't use more than the fabled 137GB.

Can the Linux Kernel then use the full drive (160GB/250GB/whatever)
even though the BIOS doesn't? (LBA48)

That's question number 1.

Question 2: Does the nForce chipset handle LBA48?

They are related but please answer question 1 even if question 2
is "no" :)

I tried looking for the answers myself but couldn't find a definite
answer. If it's plain in sight somewhere, please point me in the right
direction.

// Stefan

