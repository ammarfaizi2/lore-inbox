Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVCUD01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVCUD01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 22:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVCUD00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 22:26:26 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:29903 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261542AbVCUD0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 22:26:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=GzyoAZuSnhy1rzgYC6El8jJLMHjqicAjrhpDWS8HynS4TuwoQjeOog1rXe1cU9F78SSYFf6pngJ3do8Be9GbUdx0fRJWvQWDGhAsACuypxp5Z3WQlYvMXE3kBAsS2392bO2oaPEOXrhmTo7hMFJm3a6t1oFkqCXHMVq3sMA8jq4=
Message-ID: <e0716e9f0503201926e1c6e05@mail.gmail.com>
Date: Sun, 20 Mar 2005 22:26:02 -0500
From: William Beebe <wbeebe@gmail.com>
Reply-To: William Beebe <wbeebe@gmail.com>
To: Dave Jones <davej@redhat.com>, William Beebe <wbeebe@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
In-Reply-To: <20050321032221.GA29664@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050321032221.GA29664@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. That's what I thought. Sorry for the annoyance.


On Sun, 20 Mar 2005 22:22:21 -0500, Dave Jones <davej@redhat.com> wrote:
> On Sun, Mar 20, 2005 at 10:06:57PM -0500, William Beebe wrote:
> 
>  > Is this really a kernel issue? Or is there a better way in userland to
>  > stop this kind of crap?
> 
> man ulimit
> 
>                 Dave
> 
>
