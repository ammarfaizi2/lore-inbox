Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbVBIFUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbVBIFUn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 00:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVBIFUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 00:20:43 -0500
Received: from main.gmane.org ([80.91.229.2]:17028 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261787AbVBIFUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 00:20:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: [RFC] Linux Kernel Subversion Howto
Date: Tue, 08 Feb 2005 23:19:43 -0600
Message-ID: <cuc6el$7r5$2@sea.gmane.org>
References: <20050202155403.GE3117@crusoe.alcove-fr> <51cfdfdc084037ae1e3f164b0c524abc@libero.it> <20050203104501.GC3144@crusoe.alcove-fr> <87sm4cm4io.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-2-179.client.mchsi.com
User-Agent: KNode/0.8.2
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Dietsche wrote:

> Stelian Pop <stelian@popies.net> writes:
> 
>> I must test this...), plus 600 MB per working copy.
> 
> If you use svk <http://svk.elixus.org/> for the client side, there's
> (almost?) no overhead.
> 
> Regards, Olaf.

erm, svk is cool and all, but it keeps a local repository mirror (not
necessarily full I suppose, but usually it is). So it's *much* heavier on
the client side than normal svn. Pays off in several ways, but just because
it keeps it's weight in the depot folder instead of the wc folder doesn't
make it ligher (unless you use several wc's I suppose).

