Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVDLOxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVDLOxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVDLOpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 10:45:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:694 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262260AbVDLOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 10:45:01 -0400
Date: Tue, 12 Apr 2005 15:44:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ihalainen Nickolay <ihanic@dev.ehouse.ru>
Cc: Scott_Kilau@digi.com, admin@list.net.ru, linux-kernel@vger.kernel.org
Subject: Re: Digi Neo 8: linux-2.6.12_r2  jsm driver
Message-ID: <20050412144459.GB9796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ihalainen Nickolay <ihanic@dev.ehouse.ru>, Scott_Kilau@digi.com,
	admin@list.net.ru, linux-kernel@vger.kernel.org
References: <425BBB77.9000509@dev.ehouse.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425BBB77.9000509@dev.ehouse.ru>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 04:13:43PM +0400, Ihalainen Nickolay wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I compile linux-2.6.12_r2 sources with jsm support, but Digi Neo 8 is
> unsupported.
> after some code-modifications it works fine.

The patch is badly mangled, please resend with a good mailer (e.g.
mutt) or as an attachment.

Also the driver has changed a little in -mm, can you provide a diff
against that?
