Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSJTGYd>; Sun, 20 Oct 2002 02:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSJTGYc>; Sun, 20 Oct 2002 02:24:32 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:23309 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S262416AbSJTGYc>; Sun, 20 Oct 2002 02:24:32 -0400
Date: Sun, 20 Oct 2002 00:30:02 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx driver build failure
Message-ID: <671452704.1035095402@aslan.scsiguy.com>
In-Reply-To: <15794.7193.525850.601506@milikk.co.intel.com>
References: <15794.7193.525850.601506@milikk.co.intel.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The AIC 7xxx driver fails to build because the Makefile fails to
> specify the correct include path to aicasm.
> 
> Justin, are you getting this?

No, because this bug doesn't exist in the latest version of the driver
in my tree or the last set of patches I sent to Linus (a month ago??).

--
Justin

