Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTDRVmw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263216AbTDRVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:42:52 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32268 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263212AbTDRVmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:42:51 -0400
Date: Fri, 18 Apr 2003 22:54:47 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrei Ivanov <andrei.ivanov@ines.ro>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-mm4
Message-ID: <20030418225447.A8626@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrei Ivanov <andrei.ivanov@ines.ro>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50L0.0304182236480.1931-100000@webdev.ines.ro> <20030418205403.GA3366@nikolas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030418205403.GA3366@nikolas>; from bugfixer@list.ru on Fri, Apr 18, 2003 at 04:54:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 04:54:03PM -0400, Nick Orlov wrote:
> In my case sshd was not able to allocate pts...
> Actually it was not possible to allocate pts under 2.5.67-mm4 at all.

do you have the devpts filesystem mounted on /dev/pts/ ?

