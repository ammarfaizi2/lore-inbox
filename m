Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265217AbSJPAGA>; Tue, 15 Oct 2002 20:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265218AbSJPAGA>; Tue, 15 Oct 2002 20:06:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35242 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265217AbSJPAF6>;
	Tue, 15 Oct 2002 20:05:58 -0400
Date: Tue, 15 Oct 2002 17:03:06 -0700 (PDT)
Message-Id: <20021015.170306.46455933.davem@redhat.com>
To: greg@kroah.com
Cc: becker@scyld.com, jmorris@intercode.com.au, kuznet@ms2.inr.ac.ru,
       netdev@oss.sgi.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] change format of LSM hooks
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016000706.GI16966@kroah.com>
References: <20021015.131037.96602290.davem@redhat.com>
	<20021015202828.GG15864@kroah.com>
	<20021016000706.GI16966@kroah.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Greg KH <greg@kroah.com>
   Date: Tue, 15 Oct 2002 17:07:06 -0700

   David, does something like this look acceptable?
   
Yes.

   which I hope are a bit more to your liking :)

It is :-)

   The extra #includes are needed as some files were getting
   security.h picked up from shed.h in the past.
   
Ok, I was about to ask about that.

Franks a lot,
David S. Miller
davem@redhat.com
