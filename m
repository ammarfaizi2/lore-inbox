Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTBBQEh>; Sun, 2 Feb 2003 11:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBBQEh>; Sun, 2 Feb 2003 11:04:37 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:16648 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265414AbTBBQEg>; Sun, 2 Feb 2003 11:04:36 -0500
Date: Sun, 02 Feb 2003 09:13:53 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 and aic7xxx fails at every second boot...
Message-ID: <619680000.1044202433@aslan.scsiguy.com>
In-Reply-To: <20030202100141.GA31191@ulima.unil.ch>
References: <20030202100141.GA31191@ulima.unil.ch>
X-Mailer: Mulberry/3.0.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> I got this:
> 
> Linux version 2.5.59 (greg@localhost.localdomain) (gcc version 3.2.1
> (Mandrake Linux 9.1 3.2.1-3mdk)) #6 Sat Jan 25 15:09:49 CET 2003 Video
> mode to be used for restore is ffff

Try 6.2.28 from here:

http://people.FreeBSD.org/~gibbs/linux/SRC/

Both the 2.5 patch file and the tarball will drop right into
2.5.59.

--
Justin

