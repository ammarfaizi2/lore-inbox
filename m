Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293094AbSBWEyi>; Fri, 22 Feb 2002 23:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293095AbSBWEy2>; Fri, 22 Feb 2002 23:54:28 -0500
Received: from fc.capaccess.org ([151.200.199.53]:1038 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S293094AbSBWEyQ>;
	Fri, 22 Feb 2002 23:54:16 -0500
Message-id: <fc.0085841200310c810085841200310c81.310cc9@Capaccess.org>
Date: Fri, 22 Feb 2002 23:53:27 -0500
Subject: RE: andrew morton's mix
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -g -Wa,-anhl     is one of the better kept secrets in
GNUland. 

Hey GCC people...

I suggest a gcc option like --savetemps but without the .i's.
--save.s.o perhaps.

Rick Hohensee
(Not that I use C anymore...     ;o)

