Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVCUO7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVCUO7Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVCUO7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:59:24 -0500
Received: from [81.2.110.250] ([81.2.110.250]:36306 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261821AbVCUO7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:59:02 -0500
Subject: Re: pwc driver in -mm kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, Luc Saillard <luc@saillard.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050319130424.GB3316@gamma.logic.tuwien.ac.at>
References: <20050319130424.GB3316@gamma.logic.tuwien.ac.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111416966.14877.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 21 Mar 2005 14:56:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-03-19 at 13:04, Norbert Preining wrote:
> Hi Andrew, hi Luc!
> 
> I just realized that there is now the pwc driver back in -mm kernels,
> but interestingly not the one from Luc, or at least not the last
> published one (10.0.6). and wanted to ask if there is a specific reason
> for this?

I pushed the tested one as a starting point. May have been the wrong
decision but it's my fault if so

