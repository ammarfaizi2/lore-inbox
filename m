Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWEKLHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWEKLHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 07:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWEKLHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 07:07:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:28050 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030217AbWEKLHq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 07:07:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cqpuQ5lQpYZWkToPIIgosWm+12I93zR60GW0vgisckF5nq4T/n8p8a5mhRDyJ+PhsrTkd1n9EkD1D+GYuXebLZjxrC2158LL2rq0v7tN+IRGGyMKU7y+fIEHrtWHaEkPbyh4wyPRUDDRTqzdiqupflVQJgEctxQmgcMj2eaibsY=
Message-ID: <7c3341450605110407g70159436ye1a60283ed586c9@mail.gmail.com>
Date: Thu, 11 May 2006 12:07:45 +0100
From: "Nick Warne" <nick@linicks.net>
To: "Maciej Soltysiak" <solt2@dns.toxicfilms.tv>
Subject: Re: Linux 2.6.16.16
Cc: "Chris Wright" <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
In-Reply-To: <296295514.20060511123419@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060511022547.GE25010@moss.sous-sol.org>
	 <296295514.20060511123419@dns.toxicfilms.tv>
X-Google-Sender-Auth: 98d197ca087806c5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/06, Maciej Soltysiak <solt2@dns.toxicfilms.tv> wrote:

> But this one looks important, something that every kernel build
> has in its code path, however I am unable to say if I need it badly
> or maybe not.
>
> The url: http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2006-1860
> says nothing about it.
>
> Could we have a word or two under each patchlet that would qualify them
> somehow?
> Like:
> "Important, not required for all, apply if using SCTP"
> "Important, required for all, may *do bad things*, apply ASAP"
> "Critical, required for all, surely will *do bad things*, apply ASAP"

This is exactly my thoughts.  I read the changelog:

http://kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.16.16

and it does look important, but I am not sure either if I need to apply.

Good suggestion, Maciej!

Nick
