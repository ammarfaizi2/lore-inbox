Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265466AbRFVQdm>; Fri, 22 Jun 2001 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265467AbRFVQdf>; Fri, 22 Jun 2001 12:33:35 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:4233 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S265466AbRFVQdW>; Fri, 22 Jun 2001 12:33:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Timur Tabi <ttabi@interactivesi.com>, linux-kernel@vger.kernel.org
Subject: Re: Controversy over dynamic linking -- how to end the panic
Date: Fri, 22 Jun 2001 07:32:11 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com>
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com>
MIME-Version: 1.0
Message-Id: <01062207321104.00692@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 June 2001 14:46, Timur Tabi wrote:

> 1. License the Linux kernel under a different license that is effectively
> the GPL but with additional text that clarifies the binary module issue.
> Unfortunately, this license cannot be called the GPL.  Politically, this
> would probably be a bad idea.

I thought this was what the LGPL was for?

Unfortunately, it wouldn't be easy to switch from GPL to LGPL for the LInux 
kernel precisely BECAUSE Linus is not the sole copyright holder.

(Note: Richard Stallman insisted anyone who contributed a patch of any size 
to GNU sign a piece of paper handing their copyright over to the FSF.  
Unfortunately, this created so much friction around getting patches in that 
it was a significant factor to GNU stalling and forking to produce Linux.)

Rob
