Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbTE0XOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTE0XOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:14:14 -0400
Received: from front1.netvisao.pt ([213.228.128.56]:61074 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP id S264432AbTE0XON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:14:13 -0400
Date: Wed, 28 May 2003 00:28:25 +0100
From: "Paulo Andre'" <fscked@iol.pt>
To: Jeff Smith <whydoubt@yahoo.com>
Cc: linux-kernel@vger.kernel.org, mec@shout.net
Subject: Re: [PATCH] KBuild documentation - make dep
Message-Id: <20030528002825.43994e24.fscked@iol.pt>
In-Reply-To: <20030527174453.51471.qmail@web40003.mail.yahoo.com>
References: <20030527174453.51471.qmail@web40003.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 10:44:53 -0700 (PDT)
Jeff Smith <whydoubt@yahoo.com> wrote:

> Remove references to make {dep|depend} in kbuild documentation.

Perhaps a reference saying that `make dep' is not needed anymore and
that it is actually deprecated should remain in the documentation?

		Paulo
