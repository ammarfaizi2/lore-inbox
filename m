Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRKTQlP>; Tue, 20 Nov 2001 11:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281161AbRKTQlE>; Tue, 20 Nov 2001 11:41:04 -0500
Received: from mail.deis.isec.pt ([194.65.52.68]:34274 "EHLO mail.deis.isec.pt")
	by vger.kernel.org with ESMTP id <S281160AbRKTQk6>;
	Tue, 20 Nov 2001 11:40:58 -0500
Date: Tue, 20 Nov 2001 16:40:38 +0000 (WET)
From: Luis Miguel Correia Henriques <umiguel@alunos.deis.isec.pt>
To: <linux-kernel@vger.kernel.org>
Subject: copy to suer space
Message-ID: <Pine.LNX.4.31.0111201637420.13674-100000@mail.deis.isec.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to implement a kernel module that will be changing a user
process' code segment. I tried to user copy_to_user to patch the process's
code but, when I tried to read the new code (just to check...), it didn't
worked. Why was that? And what is the solution?

Thanks

Luis Henriques

