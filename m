Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWIUXqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWIUXqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 19:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWIUXqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 19:46:40 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:62348 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932118AbWIUXqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 19:46:39 -0400
Message-ID: <358882397.20533@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 22 Sep 2006 07:46:37 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans
Message-ID: <20060921234637.GA9742@mail.ustc.edu.cn>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060920135438.d7dd362b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060920135438.d7dd362b.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 01:54:38PM -0700, Andrew Morton wrote:
> 
>  The readahead code is complex, I'm unconvinced that it has a lot of benefit
>  and Wu has gone quiet.  Will drop.

Sorry, I've been putting efforts to meet the deadline of the google
SoC project "Rapid linux desktop startup through pre-caching", which
still can not be called success for now. And there's my pending paper
work...

I should be able to come back and concentrate on the readahead patch
after one month, whether it be dropped for now.  I guess it can be
further improved in complexity and performance.  It also needs a good
document for the overall design and benefits.  And sure the
performance numbers :-)

Regards,
Fengguang Wu
