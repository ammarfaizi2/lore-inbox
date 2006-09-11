Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWIKKNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWIKKNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWIKKNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 06:13:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58013 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751354AbWIKKNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 06:13:33 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1157891081.23085.1.camel@localhost.localdomain> 
References: <1157891081.23085.1.camel@localhost.localdomain>  <1157472883.9018.79.camel@localhost.localdomain> <1157885180.2977.133.camel@pmac.infradead.org> <1157886908.22571.11.camel@localhost.localdomain> <1157887240.2977.147.camel@pmac.infradead.org> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC]: New termios take 2 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 11 Sep 2006 11:13:24 +0100
Message-ID: <8398.1157969604@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> glibc needs them, nobody else does.

And uClibc, though that's a glibc equivalent.

David
