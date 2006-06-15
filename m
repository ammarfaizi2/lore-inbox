Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWFONos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWFONos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 09:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbWFONos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 09:44:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030440AbWFONor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 09:44:47 -0400
Message-ID: <4491644E.8000506@redhat.com>
Date: Thu, 15 Jun 2006 09:44:46 -0400
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.4.1 (X11/20060420)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Janne Karhunen <Janne.Karhunen@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 client reordering RENAMEs
References: <200606151638.15792.Janne.Karhunen@gmail.com>
In-Reply-To: <200606151638.15792.Janne.Karhunen@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janne Karhunen wrote:

>G'd day,
>
>Looks like that given async NFS mount Linux NFS client can reorder
>RENAMEs as well. For me this caused several eaten files :/. Didn't
>really expect RENAME to be reordered as mv is generally considered
>atomic. That, and RFC 1813 mandates RENAME to be atomic. Is this a
>known thing and do you guys consider this feature or a bug?
>

Can you construct a testcase which exhibits this behavior?

    Thanx...

       ps
