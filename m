Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTJTE2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 00:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJTE2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 00:28:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56981 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262259AbTJTE2W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 00:28:22 -0400
Date: Sun, 19 Oct 2003 21:23:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Holger.Kiehl@dwd.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Finding memory leak
Message-Id: <20031019212316.58e64378.davem@redhat.com>
In-Reply-To: <20031018175912.GC12461@wohnheim.fh-wedel.de>
References: <20031015032539.4cfe71c7.akpm@osdl.org>
	<Pine.LNX.4.44.0310171235150.23079-100000@praktifix.dwd.de>
	<20031018172353.GA12461@wohnheim.fh-wedel.de>
	<20031018174636.GB12461@wohnheim.fh-wedel.de>
	<20031018175912.GC12461@wohnheim.fh-wedel.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Oct 2003 19:59:12 +0200
Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> Andrew, DaveM, can this go into -test9?

Please have a look at current sources before asking questions
like this ok? :-)

Even as of -test7 or -test8 your patch is in there.  It's been in
there for a long time.
