Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWGJH7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWGJH7C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWGJH7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:59:01 -0400
Received: from unthought.net ([212.97.129.88]:27397 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751313AbWGJH7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:59:01 -0400
Date: Mon, 10 Jul 2006 09:59:00 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Thushara Wijeratna <thushw@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush taking CPU time during heavy NFS I/O
Message-ID: <20060710075900.GM2727@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Thushara Wijeratna <thushw@gmail.com>, linux-kernel@vger.kernel.org
References: <2625b9520607071651g2678bf40u7c9b353942f262f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2625b9520607071651g2678bf40u7c9b353942f262f9@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 04:51:06PM -0700, Thushara Wijeratna wrote:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0404.3/1173.html
> describes a patch Anddrew Morton made to resolve this issue.
> Did this make it into 2.6.9-* kernel? I have a 2.6.9-11 kernel that exhibits
> similar symptoms.

We see it on 2.6.11.11 too.

It seems 2.6.16.1 does not exhibit the problem.

-- 

 / jakob

