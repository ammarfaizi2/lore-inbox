Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTANShY>; Tue, 14 Jan 2003 13:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbTANShY>; Tue, 14 Jan 2003 13:37:24 -0500
Received: from isis.cs3-inc.com ([207.224.119.73]:24317 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id <S264944AbTANShX>;
	Tue, 14 Jan 2003 13:37:23 -0500
From: don-linux@isis.cs3-inc.com (Don Cohen)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15908.23349.763824.371300@isis.cs3-inc.com>
Date: Tue, 14 Jan 2003 10:47:17 -0800
To: Andrew Morgan <morgan@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: execve setting capabilities incorrectly ?
In-Reply-To: <3E245481.5050606@transmeta.com>
References: <200301141800.h0EI0WS13467@isis.cs3-inc.com>
	<3E245481.5050606@transmeta.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morgan writes:
 > execcap doesn't work...

Thanks.
Could I suggest appropriate updates to
http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt
(which caused me to waste a day or so).
I hope the people who can make such updates read this list.

I'd also appreciate pointers to other mechanisms for accomplishing the
same goals.  (And perhaps these belong in the above update too.)

Which still leaves the question of what strace has to do with it.
