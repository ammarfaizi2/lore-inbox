Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278072AbRJOUcI>; Mon, 15 Oct 2001 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278281AbRJOUb6>; Mon, 15 Oct 2001 16:31:58 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:10757 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S278161AbRJOUbw>; Mon, 15 Oct 2001 16:31:52 -0400
Message-Id: <200110152031.f9FKVlY56104@aslan.scsiguy.com>
To: christophe barbe <christophe.barbe.ml@online.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug 
In-Reply-To: Your message of "Mon, 15 Oct 2001 22:23:11 +0200."
             <20011015222311.E2665@turing> 
Date: Mon, 15 Oct 2001 14:31:47 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have defined __NO_VERSION__ before including module.h because in my
>understanding this is required when you include it in a multi-files module.
>Only one file must include module.h without defining the __NO_VERSION__.

I can find no reference to "__NO_VERSION__" in module.h or the files
it includes.   Perhaps this is a requirement for old kernels?

>I remember to read something about a repository for your new driver. Please
>could you point it to me and I will try it ASAP.

http://people.FreeBSD.org/~gibbs/linux/

--
Justin
