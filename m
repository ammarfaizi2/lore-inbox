Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262074AbTCRAoO>; Mon, 17 Mar 2003 19:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbTCRAoO>; Mon, 17 Mar 2003 19:44:14 -0500
Received: from rth.ninka.net ([216.101.162.244]:23275 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262074AbTCRAoN>;
	Mon, 17 Mar 2003 19:44:13 -0500
Subject: Re: assertion (newsk->state != TCP_SYN_RECV)
From: "David S. Miller" <davem@redhat.com>
To: Ross Vandegrift <ross@willow.seitz.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030312214421.GB20408@willow.seitz.com>
References: <20030312214421.GB20408@willow.seitz.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047948907.19314.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 17 Mar 2003 16:55:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 13:44, Ross Vandegrift wrote:
> I've recently noticed these messages bouncing up in my logs every now
> and again.  It's always with a particular machine, one that runs 2.4.20.
> 
> Google turns up one other post, made on Mon Jan 13
> (http://hypermail.idiosynkrasia.net/linux-kernel/archived/2003/week02/0308.html)
> but no responses or explanations followed.

Try searching harder, it's a kernel bug which is fixed in
current 2.4.21 prepatches.


