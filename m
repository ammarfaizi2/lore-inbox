Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbULFSA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbULFSA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbULFSA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:00:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261592AbULFSAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:00:43 -0500
Date: Mon, 6 Dec 2004 13:00:30 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Gang Xu <roaming_pig@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RSA in kernel
In-Reply-To: <20041206095145.P14339@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0412061259330.7825-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Chris Wright wrote:

> It's been done a few times, but nothing is in mainline.  You'll find
> it buried in digsig[1], but it's not a standalone module, and I believe
> there's still cryptoapi work needed to support assymetric crypto.

Last I recall, the IBM folk were investigating whether the crypto API 
would need to change or not (i.e. just use cipher methods).


- James
-- 
James Morris
<jmorris@redhat.com>


