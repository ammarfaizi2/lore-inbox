Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269547AbUJLJDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269547AbUJLJDo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 05:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269549AbUJLJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 05:02:56 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:59396 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269547AbUJLJBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 05:01:08 -0400
Date: Tue, 12 Oct 2004 10:00:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041012090057.GA15706@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	chrisw@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012070055.GB7003@DUMA.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012070055.GB7003@DUMA.13thfloor.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 09:00:55AM +0200, Herbert Poetzl wrote:
> and it works well, because we use it for almost
> a year now on linux-vserver ;)

Btw, could anyone explain the exact differences between linux-vserver
and this jail module?

