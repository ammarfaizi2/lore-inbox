Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVIHXnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVIHXnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVIHXnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:43:18 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:54965 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965078AbVIHXnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:43:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UKG9iUScU1/kntSEq5VOUXeMBw0XDYY/1cFiHbxZ3VF2eDBp4LJ7m8UNalo55EZM127eQptppwbqVcYv17BRljuqz6+v9Hc0tfoWCdLbRTurxnvegDJFY4dnRnid6ADdcxoULRrqEoIthsrCQaitpo6rCPeblWm+SKbgcRqr5m4=
Message-ID: <4320CC67.7000105@gmail.com>
Date: Fri, 09 Sep 2005 07:42:31 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: fbdev status (was Re: kernel status, 5 Sep 2005)
References: <20050905135546.7732ec27.akpm@osdl.org>
In-Reply-To: <20050905135546.7732ec27.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> 
> [Bugme-new] [Bug 5059] New: intelfb - do not keep console resolution
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5059

Fixed in 2.6.13

> 
> [Bugme-new] [Bug 5130] New: atyfb driver kernel panic on boot on
> 	http://bugzilla.kernel.org/show_bug.cgi?id=5130

Not really a bug, more of a misconfigured kernel. This bug is closed.

Tony
