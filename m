Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290463AbSAQVLK>; Thu, 17 Jan 2002 16:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290464AbSAQVLA>; Thu, 17 Jan 2002 16:11:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10002 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290463AbSAQVKs>; Thu, 17 Jan 2002 16:10:48 -0500
Date: Thu, 17 Jan 2002 17:58:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Chua <jchua@fedex.com>
Subject: Re: 2.4.18-pre4 can't compile cs4281m.c
In-Reply-To: <Pine.LNX.4.43.0201190409370.1165-100000@boston.corp.fedex.com>
Message-ID: <Pine.LNX.4.21.0201171757180.29396-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I forgot to "cvs add" cs4281_wrapper.h when I merged ac3 patches.

This is already fixed in my tree: Wait for pre5.

On Sat, 19 Jan 2002, Jeff Chua wrote:

> 
> Any patch for this? Sorry if there's already one posted, but I couldn't
> find it.


