Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283321AbRK2U7e>; Thu, 29 Nov 2001 15:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283368AbRK2U7Y>; Thu, 29 Nov 2001 15:59:24 -0500
Received: from clouddancer.com ([64.42.30.110]:35342 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S283321AbRK2U7K>; Thu, 29 Nov 2001 15:59:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: ethernet links should remember routes the same as addresses
In-Reply-To: <9u64q7$46m$1@phoenix.clouddancer.com>
In-Reply-To: <3C068ED1.D5E2F536@nortelnetworks.com> <9u64q7$46m$1@phoenix.clouddancer.com>
Reply-To: klink@clouddancer.com
Message-Id: <20011129205854.E4E187843A@phoenix.clouddancer.com>
Date: Thu, 29 Nov 2001 12:58:54 -0800 (PST)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In clouddancer.list.kernel, you wrote:
>
>
>I just wanted to get some opinions on this for possible inclusion in 2.5.  
>Alexey, if you have any comments...
>
>The scenario is as follows:
>
>Suppose I have a fancy routing setup, dynamically configured by different
>binaries, scripts, etc, complete with multiple addresses per link, additional
>routing rules and tables specified using iproute2, etc.
....
>Does this sound like a good idea?  How hard would this be to implement (not
>knowing what the current code looks like, I don't know how this would be done)?


Most routing daemons handle your problem just fine.  Perhaps you
should look into those daemons first, try 'bird' for instance.


-- 
Windows 2001: "I'm sorry Dave ...  I'm afraid I can't do that."

