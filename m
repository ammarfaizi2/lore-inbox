Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbTCLNoJ>; Wed, 12 Mar 2003 08:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263178AbTCLNoJ>; Wed, 12 Mar 2003 08:44:09 -0500
Received: from mail.gmx.net ([213.165.65.60]:55835 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263177AbTCLNoJ>;
	Wed, 12 Mar 2003 08:44:09 -0500
Date: Wed, 12 Mar 2003 14:54:45 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Javier Achirica <achirica@telefonica.net>
Cc: jmorris@intercode.com.au, jt@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: Cisco Aironet 340 oops with 2.4.20
Message-Id: <20030312145445.43994f2a.gigerstyle@gmx.ch>
In-Reply-To: <Pine.SOL.4.30.0303022313500.17887-100000@tudela.mad.ttd.net>
References: <3E6238EE.7050802@brad-x.com>
	<Pine.SOL.4.30.0303022313500.17887-100000@tudela.mad.ttd.net>
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

I have tested your CVS version in the last tree days. It seems to be ok now for me. No oops happened!
If it is working for other peoples too, will you send a patch to Marcelo
so that it will be included in 2.4.21?

Thank you very much!

Marc Giger

On Sun, 2 Mar 2003 23:14:59 +0100 (MET)
<achirica@users.sourceforge.net> wrote:

> 
> I have updated the CVS (airo-linux.sf.net) with a version that correctly
> implementes locking (there was a bug there). Please test it and tell me if
> it still panics.
> 
> Javier Achirica
