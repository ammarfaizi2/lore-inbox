Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWJCKPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWJCKPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWJCKPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:15:22 -0400
Received: from main.gmane.org ([80.91.229.2]:9104 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964870AbWJCKPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:15:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Devdas Bhagat <devdas@dvb.homelinux.org>
Subject: Re: Spam, bogofilter, etc
Date: Tue, 3 Oct 2006 09:40:18 +0000 (UTC)
Message-ID: <loom.20061003T113645-956@post.gmane.org>
References: <1159539793.7086.91.camel@mindpipe>  <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.95.203.224 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 Red Hat/1.0.5-0.1.el3 SeaMonkey/1.0.5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds <at> osdl.org> writes:

<snip>
> I'm sorry, but spam-filtering is simply harder than the bayesian 
> word-count weenies think it is. I even used to _know_ something about 

Spam stopping is harder than anyone thinks it is. Spam is about consent, not
content, and we have no really reliable way yet of knowing consent (except a
pure whitelist).

> If you want a yes/no kind of thing, do it on real hard issues, like not 
> accepting email from machines that aren't registered MX gateways. Sure, 

Uhm, MX is for receiving mail, not sending it. Plenty of organisations have
different hosts for MX MTAs and outbound MTAs. I work in that field, so just a
warning note for anyone who wants to take Linus' advice.

Devdas Bhagat

