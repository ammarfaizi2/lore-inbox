Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbTAWLRI>; Thu, 23 Jan 2003 06:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbTAWLRI>; Thu, 23 Jan 2003 06:17:08 -0500
Received: from [217.144.230.27] ([217.144.230.27]:2570 "HELO lexx.infeline.org")
	by vger.kernel.org with SMTP id <S265132AbTAWLRH>;
	Thu, 23 Jan 2003 06:17:07 -0500
Date: Thu, 23 Jan 2003 12:26:13 +0100 (CET)
From: Ketil Froyn <kernel@ketil.froyn.name>
X-X-Sender: ketil@lexx.infeline.org
To: Yao Minfeng <yaomf@gdufs.edu.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: new kernel fail
In-Reply-To: <005101c2c2d1$3a5b2380$81df74ca@hammer>
Message-ID: <Pine.LNX.4.44.0301231225040.13736-100000@lexx.infeline.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Yao Minfeng wrote:

> 2) all the files under /home, /usr are missing, this happens both for 2.4.12
> and 2.4.16, but when I login back to 2.4.7-10, the files are there again, I
> can't figure it out.

Perhaps you forgot to include the filesystem these are using in your 
kernel...?

Ketil

