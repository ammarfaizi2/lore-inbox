Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287751AbSAKHas>; Fri, 11 Jan 2002 02:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSAKHai>; Fri, 11 Jan 2002 02:30:38 -0500
Received: from blueberrysolutions.com ([195.165.170.195]:7297 "EHLO
	blueberrysolutions.com") by vger.kernel.org with ESMTP
	id <S287751AbSAKHa2>; Fri, 11 Jan 2002 02:30:28 -0500
Date: Fri, 11 Jan 2002 09:30:18 +0200 (EET)
From: Tony Glader <Tony.Glader@blueberrysolutions.com>
X-X-Sender: <teg@blueberrysolutions.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 Kernel Oops
In-Reply-To: <Pine.LNX.4.21.0201101831200.22287-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0201110926380.8489-100000@blueberrysolutions.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2002, Marcelo Tosatti wrote:

> Looks like memory corruption... 

Hardware-problem was my first idea also. So I changed memory - didn't 
help, changed processor - didn't help, changed mainboard - didn't help, 
changed even harddisk (because seems that the problem is with ide i/o - 
high harddisk i/o will cause lot of oopses) - didn't help.

> Mind running memtest86 ? 

I ran. It didn't found any errors.

