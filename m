Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262947AbTC0Ode>; Thu, 27 Mar 2003 09:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262949AbTC0Ode>; Thu, 27 Mar 2003 09:33:34 -0500
Received: from [81.2.110.254] ([81.2.110.254]:48117 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S262947AbTC0Odc>;
	Thu, 27 Mar 2003 09:33:32 -0500
Subject: Re: Obsolete messages ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048774874.19677.0.camel@rth.ninka.net>
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com>
	 <1048774874.19677.0.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048776371.2606.60.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 27 Mar 2003 14:46:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 14:21, David S. Miller wrote:
> If you fix the apps, the messages go away.  In fact, you want to know
> that you have unfixed apps on your box when you run these kernels so
> I'd say the messages should stay even well into early 2.6.x

In which case they would benefit from net/shut_up sysctl. In lots of
environments they will just be a pain

