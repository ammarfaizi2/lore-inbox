Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313685AbSDHQCi>; Mon, 8 Apr 2002 12:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313683AbSDHQCg>; Mon, 8 Apr 2002 12:02:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31411 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313685AbSDHQBb>;
	Mon, 8 Apr 2002 12:01:31 -0400
Date: Mon, 08 Apr 2002 08:54:44 -0700 (PDT)
Message-Id: <20020408.085444.52620439.davem@redhat.com>
To: jarlath.burke@asitatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RARP server support on Linux 2.4
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <NCEGLAPNBLBCNHJEMJEKEEBGDCAA.jarlath.burke@asitatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to maintain the ethernet address to IP address database
in /etc/ethers.
