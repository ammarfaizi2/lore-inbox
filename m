Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTEVHdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 03:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTEVHdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 03:33:42 -0400
Received: from rth.ninka.net ([216.101.162.244]:19843 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262569AbTEVHdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 03:33:41 -0400
Subject: Re: [CHECKER] 12 potential leaks in kernel 2.5.69
From: "David S. Miller" <davem@redhat.com>
To: Ted Kremenek <kremenek@cs.stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
In-Reply-To: <BAF1B694.8EBC%kremenek@cs.stanford.edu>
References: <BAF1B694.8EBC%kremenek@cs.stanford.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053589602.26737.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 May 2003 00:46:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-21 at 23:04, Ted Kremenek wrote:
> As always, confirmation of these reports is appreciated.

I took care of the two ipv6 bugs spotted, they were
legitimate.  Thanks.

