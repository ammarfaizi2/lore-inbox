Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289854AbSAXAmC>; Wed, 23 Jan 2002 19:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSAXAl5>; Wed, 23 Jan 2002 19:41:57 -0500
Received: from rj.SGI.COM ([204.94.215.100]:55501 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289854AbSAXAlu>;
	Wed, 23 Jan 2002 19:41:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre7 
In-Reply-To: Your message of "Wed, 23 Jan 2002 19:55:46 -0200."
             <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 24 Jan 2002 11:41:40 +1100
Message-ID: <32417.1011832900@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three generated files have crept into the patch.  They need to be
deleted.  rm drivers/sound/*_boot.h

