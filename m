Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSLUPyx>; Sat, 21 Dec 2002 10:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSLUPyx>; Sat, 21 Dec 2002 10:54:53 -0500
Received: from mnh-1-28.mv.com ([207.22.10.60]:33284 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S261640AbSLUPyw>;
	Sat, 21 Dec 2002 10:54:52 -0500
Message-Id: <200212211607.LAA01515@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: John Reiser <jreiser@BitWagon.com>
Cc: linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       Julian Seward <jseward@acm.org>
Subject: Re: Valgrind meets UML 
In-Reply-To: Your message of "Sat, 21 Dec 2002 06:40:44 PST."
             <3E047D6C.1030702@BitWagon.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 21 Dec 2002 11:07:02 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jreiser@BitWagon.com said:
> In order to prevent races between valgrind for UML and kernel
> allocators which valgrind does not "know", then the VALGRIND_*
> declarations being added to kernel allocators should allow for
> expressing the concept "atomically change state in both allocator and
> valgrind".

What are you talking about?

There are no atomicity problems between UML and valgrind.

				Jeff

