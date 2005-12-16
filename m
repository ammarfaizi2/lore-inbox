Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVLPHlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVLPHlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 02:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVLPHlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 02:41:23 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:21026 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932166AbVLPHlW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 02:41:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f54ggxxEpYOsCK/ejLbUgMlhQe8CHX/B/9z86up2cYa0YmXFQKHzO89A/M3ZGEt5dnUA3ZRknXrwGa2WT+OSh0/RYiJzolGzP626wcNhey9GQJ4XMxmd7ZGwc2wyKSM0XEt7Kr5T+nDJE0PdzZe4qJ7HE01kzQwngbV4oSc+VjI=
Message-ID: <84144f020512152341n2cd01251u852abc1e56f4ab22@mail.gmail.com>
Date: Fri, 16 Dec 2005 09:41:21 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051216061605.46520.qmail@web50211.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051216052913.GD30754@redhat.com>
	 <20051216061605.46520.qmail@web50211.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 12/16/05, Alex Davis <alex14641@yahoo.com> wrote:
> I understand that, and am grateful for the effort, but the point is it's not ready. Are you
> expecting people to lose an important feature of their
> laptop until you get the driver ready?

Hey, it's the price you pay for using binary only drivers. Why not
complain to Broadcom instead for not releasing the hardware
documentation? Besides, you can still maintain 8 KB stacks as an
out-of-tree patch or change fix ndiswrapper work with 4 KB ones.

                              Pekka
