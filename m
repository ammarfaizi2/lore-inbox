Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWBITZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWBITZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 14:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWBITZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 14:25:51 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:1977 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750728AbWBITZu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 14:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rfcHZQjTqt//LBWoELkxhTu3g/3jZQ0zY5RF6yJBeb/OgsBdup8pnwmodDN26S/PaQiDq1AhUXjl1/eCNN9QnG/AejCDuAZLpCNNvKMHwMxHibhdukZeu1GVViUxz8Wzy/HUiVOCek/8VrzAeYwXSxwBqKuPr0S6T0JG6YL75MU=
Message-ID: <cbec11ac0602091125w5a5a7c6em8462131e9f9b24dc@mail.gmail.com>
Date: Fri, 10 Feb 2006 08:25:49 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: bb@kernelpanic.ru
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       Yoseph Basri <yoseph.basri@gmail.com>, linux-kernel@vger.kernel.org,
       NetDEV list <netdev@vger.kernel.org>
In-Reply-To: <43EB9548.9060504@kernelpanic.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
	 <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
	 <43EB9548.9060504@kernelpanic.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Boris B. Zhmurov <bb@kernelpanic.ru> wrote:
> Hello, Jesse Brandeburg.
>
> On 08.02.2006 23:07 you said the following:
>
> > whats the relevance of e1000?
> >
> > I though Herbert had fixed these
>
> Nope :( I had this messages on 2.6.14.2 and now I have it on 2.6.15.3.
>
For what it's worth I had these messages for a while and they got
fixed 2 or 3 weeks ago from memory in Dave's 2.6.16 net tree or net2.6
tree.

Is it possible for you to download 2.6.16-rc2 or similar and see if it
goes away?

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
