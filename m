Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUJ0RGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUJ0RGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbUJ0RCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:02:51 -0400
Received: from canuck.infradead.org ([205.233.218.70]:45580 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262501AbUJ0Q7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:59:41 -0400
Subject: RE: My thoughts on the "new development model"
From: Arjan van de Ven <arjan@infradead.org>
To: hzhong@cisco.com
Cc: "'John Richard Moser'" <nigelenki@comcast.net>,
       =?gb2312?B?J0VzcGVuIEZqZWxsduZyIE9sc2VuJw==?= <espenfjo@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <014d01c4bb7d$0baba180$ca41cb3f@amer.cisco.com>
References: <014d01c4bb7d$0baba180$ca41cb3f@amer.cisco.com>
Content-Type: text/plain
Message-Id: <1098896367.6990.24.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 27 Oct 2004 18:59:27 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-26 at 09:58 -0700, Hua Zhong wrote:
> The fact is, these days nobody wants to be a stable-release maintainer
> anymore. It's boring.

I wouldn't mind doing some sort of bugfix kernel series it if people
think it'd be useful... but that's a big if.... the hard part of any
such tree is finding people who help testing, and yet the customers of
such a tree are those who only want proven stable stuff ;)

-- 

