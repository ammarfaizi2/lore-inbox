Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261170AbULMJwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbULMJwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 04:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbULMJwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 04:52:19 -0500
Received: from gate.ebshome.net ([64.81.67.12]:57486 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S261170AbULMJwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 04:52:15 -0500
Date: Mon, 13 Dec 2004 01:52:13 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [BUG?] [PPC/403/IBM] compile error 2.6.9 and earlier
Message-ID: <20041213095213.GB917@gate.ebshome.net>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
References: <20041213091027.GA2384@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213091027.GA2384@schottelius.org>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 10:10:28AM +0100, Nico Schottelius wrote:
> I didn't find linux-ppc list on vger, so I hope this list is correct:

Look at http://ozlabs.org/mailman/listinfo. I'm forwarding my reply to 
linuxppc-embedded as well.

> When trying to compile a kernel for my ibm thinclient, which has a
> 403 PPC processor, I get the attached compile error. 

Yes, it's a known problem, 403 build is broken and 4xx maintainer told 
me that it hadn't been removed completely mostly because of 
sentimental reasons (IIRC first TiVos used 403 chip);

Looks like we have a person who needs it working. Feel free to fix it 
and submit a patch :).

--
Eugene
