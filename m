Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292353AbSBYWWp>; Mon, 25 Feb 2002 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292352AbSBYWWj>; Mon, 25 Feb 2002 17:22:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28065 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292350AbSBYWVv>;
	Mon, 25 Feb 2002 17:21:51 -0500
Date: Mon, 25 Feb 2002 14:19:11 -0800 (PST)
Message-Id: <20020225.141911.116368818.davem@redhat.com>
To: rainer@ellinger.de
Cc: marcelo@conectiva.com.br, DevilKin-LKML@blindguardian.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C7AB893.4090800@ellinger.de>
In-Reply-To: <Pine.LNX.4.21.0202251631170.31542-100000@freak.distro.conectiva>
	<20020225.140851.31656207.davem@redhat.com>
	<3C7AB893.4090800@ellinger.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rainer Ellinger <rainer@ellinger.de>
   Date: Mon, 25 Feb 2002 23:20:03 +0100

   David S. Miller wrote:
   
   > We can avoid this kind of mess in the future if the "-rc*" releases
   > really are "release candidates" instead of "just another diff".
   
   And how should EXTRAVERSION be accommodated?

It's empty, if it isn't empty then it really isn't a
"release candidate" since changes will be made now is
it? :-)
