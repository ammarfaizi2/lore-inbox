Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSKIVNT>; Sat, 9 Nov 2002 16:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262679AbSKIVNT>; Sat, 9 Nov 2002 16:13:19 -0500
Received: from mnh-1-11.mv.com ([207.22.10.43]:6661 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262667AbSKIVNT>;
	Sat, 9 Nov 2002 16:13:19 -0500
Message-Id: <200211102122.QAA02565@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1 - hang with processes stuck in D 
In-Reply-To: Your message of "Fri, 08 Nov 2002 07:01:38 -0200."
             <Pine.LNX.4.44L.0211080700120.27560-100000@freak.distro.conectiva> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 10 Nov 2002 16:22:57 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

marcelo@conectiva.com.br said:
> Or rather try it on a different box. 

This has been seen on a number of different boxes running a variety of kernels.

The ones that have happened to other people that I have heard of have all
involved UML.  I've also make my laptop hang with BK, diff, and emacs.

Here are some threads talking about this problem:

    http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=103644225423660&w=2
and http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=103644252023954&w=2

    http://marc.theaimsgroup.com/?l=linux-kernel&m=103351640614665&w=2

    http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=103582756229685&w=2
and http://marc.theaimsgroup.com/?l=user-mode-linux-user&m=103582861831037&w=2

There's a variety of kernels and hardware involved here.  My laptop is 
bog-standard IDE afaik.  Zaphod, the subject of the second URL, is IDE behind
a 3ware raid controller.  Not sure about the others.

				Jeff

