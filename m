Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161146AbVIPJpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161146AbVIPJpg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 05:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161148AbVIPJpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 05:45:36 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:42944 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161146AbVIPJpf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 05:45:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NfcQ9Kv9yEGy6vov5s5YbRmZr578H3luiyefjTex6sxfUN5O09CZzjXx1Vm5UwX0EUxI0Cc+yr+s3a71U6q7wNXr479EBgLQYTVEGyV7hqc2j6BSU4Uw3lCGou4Lt7KnagEgKMQPtlX3OF3fsE2VfKuFH/3cDAAVBB8ON2mz8io=
Message-ID: <84144f020509160245445fc58a@mail.gmail.com>
Date: Fri, 16 Sep 2005 12:45:34 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc1-mm1
Cc: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
In-Reply-To: <20050916022319.12bf53f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050916022319.12bf53f3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Andrew Morton <akpm@osdl.org> wrote:
> - Big reiser4 update which is said to address all review comments.

One relatively minor issue not addressed: type safe hash is in
fs/reiser4/ and not in include/linux/.

                                     Pekka
