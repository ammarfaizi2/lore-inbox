Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280894AbRKOPLp>; Thu, 15 Nov 2001 10:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280892AbRKOPLf>; Thu, 15 Nov 2001 10:11:35 -0500
Received: from pizda.ninka.net ([216.101.162.242]:32400 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280895AbRKOPLW>;
	Thu, 15 Nov 2001 10:11:22 -0500
Date: Thu, 15 Nov 2001 07:11:05 -0800 (PST)
Message-Id: <20011115.071105.45157375.davem@redhat.com>
To: summer@os2.ami.com.au
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: BOOTP and 2.4.14
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200111150629.fAF6SKg20602@numbat.os2.ami.com.au>
In-Reply-To: <200111150629.fAF6SKg20602@numbat.os2.ami.com.au>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set your kernel command line correctly, the format is:

	HOSTNAME.NIS_DOMAINNAME

It has been like this since ancient times :-)
