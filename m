Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290468AbSAQVOA>; Thu, 17 Jan 2002 16:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290467AbSAQVNx>; Thu, 17 Jan 2002 16:13:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57227 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290466AbSAQVNf>;
	Thu, 17 Jan 2002 16:13:35 -0500
Date: Thu, 17 Jan 2002 13:12:24 -0800 (PST)
Message-Id: <20020117.131224.108809922.davem@redhat.com>
To: fabien.ribes@cgey.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in sock_poll
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C470105.ED9DDCE@cgey.com>
In-Reply-To: <3C470105.ED9DDCE@cgey.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can you reproduce this with a more recent kernel?  Anything
>=2.4.9 (this includes all Red Hat errata kernels therefore)
would be sufficient.

And also please provide a full decoded OOPS log as well, thanks.
