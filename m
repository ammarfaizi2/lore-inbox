Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSJULyR>; Mon, 21 Oct 2002 07:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbSJULyR>; Mon, 21 Oct 2002 07:54:17 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:57523 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261340AbSJULyQ>; Mon, 21 Oct 2002 07:54:16 -0400
Subject: Re: AIC7xxx driver build failure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <671452704.1035095402@aslan.scsiguy.com>
References: <15794.7193.525850.601506@milikk.co.intel.com> 
	<671452704.1035095402@aslan.scsiguy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 13:15:58 +0100
Message-Id: <1035202558.27309.64.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-20 at 07:30, Justin T. Gibbs wrote:
> > The AIC 7xxx driver fails to build because the Makefile fails to
> > specify the correct include path to aicasm.
> > 
> > Justin, are you getting this?
> 
> No, because this bug doesn't exist in the latest version of the driver
> in my tree or the last set of patches I sent to Linus (a month ago??).

Care to send me the stuff Linus has dropped ?

