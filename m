Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312634AbSELLfo>; Sun, 12 May 2002 07:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312681AbSELLfn>; Sun, 12 May 2002 07:35:43 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:57100 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312634AbSELLfm>;
	Sun, 12 May 2002 07:35:42 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre8-ac2 does not compile 
In-Reply-To: Your message of "Sun, 12 May 2002 13:06:53 +0200."
             <3CDE4CCD.99F5D0BE@wanadoo.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 21:35:29 +1000
Message-ID: <22563.1021203329@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002 13:06:53 +0200, 
Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr> wrote:
>make[2]: *** No rule to make target `.tmp_include_depends'.  Stop.

'make clean dep' instead of 'make dep clean', or apply
http://marc.theaimsgroup.com/?l=linux-kernel&m=102119861820626&w=2

