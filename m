Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWEOSlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWEOSlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWEOSlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:41:53 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:10251 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750978AbWEOSlw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:41:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hYhbEObXeckZIa7nRUr1DIlRq/8NSOFmNexRjM+XpN+1jYsPtDVluHYqecuyT0Sqoo5AA++i6MJ77GKnoPjWdL0dmu0yWRbBcd40fXD1p9seek0eQKc10UYth0Kw9kN/nyTDbSvl6nTjlC1whj8kTiiI3edjg0HPji6oEWUKmRg=
Message-ID: <91740af30605151141j1241bd62q925cd7c1f858d75b@mail.gmail.com>
Date: Mon, 15 May 2006 14:41:51 -0400
From: "Rohan Mutagi" <rohan208@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: netdump netpoll bug?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time my system panics and  my client is dumping the vmcore to
the netdump-server, I get error "netpoll_start_netdump: called
recursively. rebooting". and my client reboots. And I get a
vmcore-incomplete file. I did a fresh install of Linux RHEL4-WS and
still get the same problem. Any ideas how to proceed?

google search for "netpoll_start_netdump" .. "netdump bug recursively"
etc dint return any perceivable results.. any leads would be
appreciated..

also if this is the wrong place to post, I would appriciate it if i
coudl know the right place to post this message?


Thanks a lot,
Rohan Mutagi
