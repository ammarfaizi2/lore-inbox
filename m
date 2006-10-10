Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWJJSZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWJJSZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWJJSZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 14:25:18 -0400
Received: from gw.goop.org ([64.81.55.164]:21963 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965082AbWJJSZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 14:25:17 -0400
Message-ID: <452BE591.3090209@goop.org>
Date: Tue, 10 Oct 2006 11:25:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Miguel Ojeda <maxextreme@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
References: <20061010000928.9d2d519a.akpm@osdl.org>	 <653402b90610100031i5132083ewba1240d01981f4ae@mail.gmail.com>	 <20061010011052.f22a55da.akpm@osdl.org> <653402b90610100257t53f62cf5y75875ed7e7cb479c@mail.gmail.com>
In-Reply-To: <653402b90610100257t53f62cf5y75875ed7e7cb479c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda wrote:
> Allright, I will code it as the fbcfag12864b module, and when it will
> be working fine, I will remove the raw device of the cfag12864b and if
> the code of fbcfag12864b results really small/trivial, I will put it
> in the cfag12864b module. Then I will send you the "update patch 2".
>
> Give me a couple of days or so :)

Just as an aside, would it be possible to give this module a name which 
doesn't look like a changeset ID?  It's only the 'g' which gives it away...

    J
