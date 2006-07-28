Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161149AbWG1Tev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161149AbWG1Tev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWG1Teu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:34:50 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:5519 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1030286AbWG1Teu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:34:50 -0400
Message-ID: <44CA66D8.3010404@oracle.com>
Date: Fri, 28 Jul 2006 12:34:48 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: Benjamin LaHaise <bcrl@kvack.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727205806.GD16971@kvack.org> <44C933D2.4040406@oracle.com> <20060727220238.GE16971@kvack.org> <44CA5F08.3080500@oracle.com> <20060728192403.GA13690@2ka.mipt.ru>
In-Reply-To: <20060728192403.GA13690@2ka.mipt.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> On Fri, Jul 28, 2006 at 12:01:28PM -0700, Zach Brown (zach.brown@oracle.com) wrote:
>> Clearly we should port httpd to kevents and take some measurements :)
> 
> One of my main kevent benchmarks (socket notifications for
> accept/receive) is handmade http server.

Yeah, so I noticed.  That's a good starting point but I'm more
interested in seeing the work integrated with servers that have to
survive outside of benchmarking runs.

- z
