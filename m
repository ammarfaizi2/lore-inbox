Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbUJZECT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbUJZECT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbUJZD5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:57:50 -0400
Received: from almesberger.net ([63.105.73.238]:11023 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262155AbUJZD4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:56:08 -0400
Date: Tue, 26 Oct 2004 00:55:59 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: hch@lst.de, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead tcp exports
Message-ID: <20041026005559.A305@almesberger.net>
References: <20041024134309.GB20267@lst.de> <20041026000710.D3841@almesberger.net> <20041025204147.667ee2b1.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025204147.667ee2b1.davem@davemloft.net>; from davem@davemloft.net on Mon, Oct 25, 2004 at 08:41:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> There are scripts which build everything as possible as modules
> then greps the symbol tables of the object files to see which
> symbols exported by the kernel are actually used.

Hmm yes, modules maintained outside of the tree live dangerously ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
