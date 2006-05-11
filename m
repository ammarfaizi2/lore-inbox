Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965061AbWEKC6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWEKC6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWEKC6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:58:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:13776 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965061AbWEKC6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:58:14 -0400
X-Authenticated: #14349625
Subject: Re: [PATCH -mm] sys_semctl gcc 4.1 warning fix
From: Mike Galbraith <efault@gmx.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, viro@ftp.linux.org.uk, dwalker@mvista.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060510.153007.19037157.davem@davemloft.net>
References: <1147275522.21536.109.camel@c-67-180-134-207.hsd1.ca.comcast.net>
	 <20060510162106.GC27946@ftp.linux.org.uk>
	 <20060510150321.11262b24.akpm@osdl.org>
	 <20060510.153007.19037157.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 11 May 2006 04:58:05 +0200
Message-Id: <1147316285.8432.17.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 15:30 -0700, David S. Miller wrote:
> Even a huge tree like gcc can build itself %100 fine with -Werror, for

What's the emoticon for coffee going down your windpipe?

	-Mike

