Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310127AbSCFTNq>; Wed, 6 Mar 2002 14:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310130AbSCFTNh>; Wed, 6 Mar 2002 14:13:37 -0500
Received: from est196.fciencias.unam.mx ([132.248.109.196]:13828 "EHLO
	est196.fciencias.unam.mx") by vger.kernel.org with ESMTP
	id <S293749AbSCFTNW>; Wed, 6 Mar 2002 14:13:22 -0500
Date: Wed, 6 Mar 2002 13:11:05 -0600
Message-Id: <200203061911.g26JB5e01303@est196.fciencias.unam.mx>
From: Dario Bahena Tapia <dario.bahena@correo.unam.mx>
To: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dario.bahena@correo.unam.mx
Subject: getting process i/o wasted time ...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi linux hackers ...

I'd like to know, if there's a way to get the ammount of time wasted by a
process, while it was making i/o. I've seen that the rusage
makes available the ammount of i/o blocks, but I'm thinking in something
like:

          process warawara ...
          time wasted in disks i/o .... XXX
          time wasted in net i/o   .... XXX
          etc. ???

Doest it makes sense? it could be done in linux?

I supposed ,that I can insert some system calls in the right places
in the program to make this... but I'm interested in a non-intrusive
method ...

Thanks in advance

saludos
dario estepario ...


