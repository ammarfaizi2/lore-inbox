Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030349AbWFISd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbWFISd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbWFISdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:33:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030349AbWFISdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:33:55 -0400
Date: Fri, 9 Jun 2006 11:33:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Leubner, Achim" <Achim_Leubner@adaptec.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: HEADS UP for gdth driver users
Message-Id: <20060609113341.41d9041a.akpm@osdl.org>
In-Reply-To: <EF6AF37986D67948AD48624A3E5D93AFAA967C@mtce2k01.adaptec.com>
References: <EF6AF37986D67948AD48624A3E5D93AFAA967C@mtce2k01.adaptec.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jun 2006 13:03:08 +0200
"Leubner, Achim" <Achim_Leubner@adaptec.com> wrote:

> Attached you find a patch to remove the scsi_request interface from the
> gdth driver.

Please send a changelog and a Signed-off-by: for this patch, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and
Documentation/SubmittingPatches.

Please ensure that future patches are prepared in `patch -p1' form, as per
the same documents, thanks.

