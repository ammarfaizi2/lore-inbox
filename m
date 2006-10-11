Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWJKRPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWJKRPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 13:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWJKRPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 13:15:10 -0400
Received: from lixom.net ([66.141.50.11]:13769 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1161150AbWJKRPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 13:15:09 -0400
Date: Wed, 11 Oct 2006 12:10:56 -0500
From: Olof Johansson <olof@lixom.net>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Linas Vepstas <linas@austin.ibm.com>, Bryce Harrington <bryce@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Potential fix for fdtable badness.
Message-ID: <20061011121056.0816ff51@localhost.localdomain>
In-Reply-To: <200610101908.18442.vlobanov@speakeasy.net>
References: <200610101908.18442.vlobanov@speakeasy.net>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 19:08:18 -0700 Vadim Lobanov <vlobanov@speakeasy.net> wrote:

> All,
> 
> Sorry about the recent fdtable badness that you all encountered. I'm working
> on getting a fix out there.
> 
> Dave, Olof, Linas, Bryce,
> 
> Could you please test the patch at the bottom of the email to see if it makes
> your computers happy again, if you have the time and inclination to do so?

Looks good to me.


-Olof
