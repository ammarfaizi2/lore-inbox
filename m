Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274513AbRJNGkJ>; Sun, 14 Oct 2001 02:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274520AbRJNGj7>; Sun, 14 Oct 2001 02:39:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12427 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274513AbRJNGjt>;
	Sun, 14 Oct 2001 02:39:49 -0400
Date: Sat, 13 Oct 2001 23:40:16 -0700 (PDT)
Message-Id: <20011013.234016.104032175.davem@redhat.com>
To: Mika.Liljeberg@welho.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP acking too fast
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
In-Reply-To: <3BC8DAF0.3D16A546@welho.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You need to post for us a tcpdump trace of a connection you feel
exhibits bad behavior.

Otherwise we can do nothing but guess, effectively your statistics
aren't helpful at all if we have no idea what is happening on the
wire.

Franks a lot,
David S. Miller
davem@redhat.com
