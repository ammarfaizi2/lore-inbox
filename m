Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbUJZDMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUJZDMB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbUJZDHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:07:48 -0400
Received: from almesberger.net ([63.105.73.238]:54030 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262138AbUJZDHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:07:25 -0400
Date: Tue, 26 Oct 2004 00:07:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Christoph Hellwig <hch@lst.de>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove dead tcp exports
Message-ID: <20041026000710.D3841@almesberger.net>
References: <20041024134309.GB20267@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041024134309.GB20267@lst.de>; from hch@lst.de on Sun, Oct 24, 2004 at 03:43:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wheee, you had me scared for a moment. But indeed, not even tcpcp
(tcpcp.sf.net) uses any of these. But I kind of wonder how you
determine they're "dead" ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
