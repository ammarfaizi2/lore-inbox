Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbTIEOoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTIEOoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:44:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14520 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263097AbTIEOoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:44:05 -0400
Date: Fri, 5 Sep 2003 07:34:03 -0700
From: "David S. Miller" <davem@redhat.com>
To: Erlend Aasland <erlend-a@ux.his.no>
Cc: jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: [CRYPTO] add alg. type to /proc/crypto output
Message-Id: <20030905073403.0b939b0a.davem@redhat.com>
In-Reply-To: <20030905143859.GA18143@johanna5.ux.his.no>
References: <20030905143859.GA18143@johanna5.ux.his.no>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003 16:38:59 +0200
Erlend Aasland <erlend-a@ux.his.no> wrote:

> Here is a patch that add alg. type output to /proc/crypto. Booted and
> tested.

Is it even useful?

When you see names like "md5" and parameters such as "digestsize"
listed, do you really have no clue that it is a "digest"?  :-)

The information seems completely redundant to me.
