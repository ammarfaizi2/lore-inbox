Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbVLSRE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbVLSRE3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbVLSRE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:04:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57813 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964860AbVLSRE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:04:28 -0500
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
	DECT PABX
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Tilman Schmidt <tilman@imap.cc>, Stephen Hemminger <shemminger@osdl.org>,
       Hansjoerg Lipp <hjlipp@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1135011676.20747.3.camel@mindpipe>
References: <20051212181356.GC15361@hjlipp.my-fqdn.de>
	 <43A6E209.5030406@imap.cc>  <1135011676.20747.3.camel@mindpipe>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 18:04:19 +0100
Message-Id: <1135011859.2947.11.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 12:01 -0500, Lee Revell wrote:
> On Mon, 2005-12-19 at 17:38 +0100, Tilman Schmidt wrote:
> > Unfortunately these don't fit our needs, as we are not dealing with a
> > network device, but with an ISDN device.
> 
> Um, isn't that what the N in ISDN stands for?
> 
> I guess what you mean is that although ISDN devices are obviously
> networking devices, the kernel uses a separate subsystem for 

that's not obvious. They're telephony like devices. they do voice and
data. They're not ethernet or even remotely like that. You can do ppp
over it tho... 


