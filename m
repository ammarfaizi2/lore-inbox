Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282227AbRKWU0O>; Fri, 23 Nov 2001 15:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282226AbRKWU0D>; Fri, 23 Nov 2001 15:26:03 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13965 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282229AbRKWUZp>;
	Fri, 23 Nov 2001 15:25:45 -0500
Date: Fri, 23 Nov 2001 12:25:38 -0800 (PST)
Message-Id: <20011123.122538.74728853.davem@redhat.com>
To: ndressler@dinmar.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparc64 Compiles OK, but won't boot new kernel
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <002101c17430$d94b2f80$3828a8c0@ndrlaptop>
In-Reply-To: <002101c17430$d94b2f80$3828a8c0@ndrlaptop>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compile more things as modules, your kernel has too many things
compiled statically into it and is therefore too large to boot.
