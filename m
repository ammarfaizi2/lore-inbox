Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292901AbSB0Tl4>; Wed, 27 Feb 2002 14:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292911AbSB0Tlh>; Wed, 27 Feb 2002 14:41:37 -0500
Received: from www.transvirtual.com ([206.14.214.140]:23310 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S292901AbSB0Tj7>; Wed, 27 Feb 2002 14:39:59 -0500
Date: Wed, 27 Feb 2002 11:39:52 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ben Clifford <benc@hawaga.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj2 oops
In-Reply-To: <Pine.LNX.4.33.0202271014380.13407-100000@barbarella.hawaga.org.uk>
Message-ID: <Pine.LNX.4.10.10202271137380.4758-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay folks. Here is another patch to fix the oops. It is against a
2.5.5-dj2 tree. I have tested against vgacon and fbcon. Note it still 
is incomplete since a few fbdev drivers break. If they where ported over
to the new api this wouldn't be a issue. 

http://www.transvirtual.com/~jsimmons/console/console_8.diff


