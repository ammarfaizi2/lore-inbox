Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290669AbSARK5d>; Fri, 18 Jan 2002 05:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290664AbSARK5X>; Fri, 18 Jan 2002 05:57:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40337 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290668AbSARK5N>;
	Fri, 18 Jan 2002 05:57:13 -0500
Date: Fri, 18 Jan 2002 02:55:54 -0800 (PST)
Message-Id: <20020118.025554.133432828.davem@redhat.com>
To: fabien.ribes@cgey.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in sock_poll
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C47E46C.2E322EC6@cgey.com>
In-Reply-To: <3C470105.ED9DDCE@cgey.com>
	<20020117.131224.108809922.davem@redhat.com>
	<3C47E46C.2E322EC6@cgey.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Fabien Ribes <fabien.ribes@cgey.com>
   Date: Fri, 18 Jan 2002 09:01:32 +0000

   "David S. Miller" wrote:
   > 
   > Can you reproduce this with a more recent kernel?  Anything
   > >=2.4.9 (this includes all Red Hat errata kernels therefore)
   > would be sufficient.

   The kernel used is customized in many ways, it is a long work to upgrade

Then I can't help you... there have probably been many
networking bugs fixed since 2.4.9
