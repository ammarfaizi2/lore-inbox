Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276962AbRJKVq7>; Thu, 11 Oct 2001 17:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276966AbRJKVqu>; Thu, 11 Oct 2001 17:46:50 -0400
Received: from anime.net ([63.172.78.150]:2570 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S276962AbRJKVqk>;
	Thu, 11 Oct 2001 17:46:40 -0400
Date: Thu, 11 Oct 2001 14:46:51 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Marcus Meissner <mm@ns.caldera.de>
cc: war <war@starband.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Can only login via ssh 1013 times.
In-Reply-To: <200110112136.f9BLakI04545@ns.caldera.de>
Message-ID: <Pine.LNX.4.30.0110111445140.2188-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001, Marcus Meissner wrote:
> You maximum of open files is too low.
> Increase the value /proc/sys/fs/file-max (check current usage in file-nr).

Maybe kernel could printk a warning when file-max (or other) limit is
reached...?

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

