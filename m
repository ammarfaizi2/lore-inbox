Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbTKZXOl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTKZXOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:14:41 -0500
Received: from [212.35.254.18] ([212.35.254.18]:24770 "EHLO mail2.midnet.co.uk")
	by vger.kernel.org with ESMTP id S264368AbTKZXOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:14:39 -0500
Date: Wed, 26 Nov 2003 23:14:39 +0000
From: Tim Kelsey <accent0@mail2.midnet.co.uk>
To: Tim Kelsey <tk@midnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help building module for 2.6.0
Message-Id: <20031126231439.297344aa.accent0@mail2.midnet.co.uk>
In-Reply-To: <20031126230550.37785544.tk@midnet.co.uk>
References: <20031126230550.37785544.tk@midnet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 23:05:50 +0000
Tim Kelsey <tk@midnet.co.uk> wrote:

> ok im trying to build a kernel module (my first :) ) when i build it on a 2.4 box everything is fine when i build it on my laptop running 2.6.0-t10 it builds fine but when i try and insmod it i get 
> 
> sh$ insmod ./hgn.o 
> insmod: error inserting './hgn.o': -1 Invalid module format
> 
> I have attached my Makefile. Please could some one tell me if this is due to the way i compile the module (my guess) or if it is likly caused by my code. Any pointers would be welcome.
> 
> Thnx for any help
> Tim Kelsey
> 
> 
> p.s. I know this is kind of like walking into a filharmonic auchestra with a waveing a tin drum :P so if there is a more apropriate place to post this kind of question pls let me know.

*blush* this time i even included the make file, *goes to find much needed coffee* (sorry about poor spelling)


> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
