Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWHORNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWHORNA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWHORNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:13:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:13773 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030389AbWHORM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:12:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h8UIsTAx5/XrGXbGiq5ueSD+5QlCVhSeh5N6ES2bosAiWNPlwgWV9ETdLJtWpQduHSjeh5X+/gDcDsWjtsYqu8+wI9w+BA63hi+IR38fwofifx5fIhKXntqQH7nqciPsCcttTwbE4nOJsiMcvYlUd+UDhKujz3/FIVKMfKXoryA=
Message-ID: <d120d5000608151012y27c1ea2h4adda366112868a7@mail.gmail.com>
Date: Tue, 15 Aug 2006 13:12:58 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: Voluspa <lista1@comhem.se>
Subject: Re: Touchpad problems with latest kernels
Cc: "Luke Sharkey" <lukesharkey@hotmail.co.uk>, andi@rhlx01.fht-esslingen.de,
       davej@redhat.com, gene.heskett@verizon.net, ian.stirling@mauve.plus.com,
       linux-kernel@vger.kernel.org, malattia@linux.it
In-Reply-To: <20060815183310.284d03ae.lista1@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
	 <BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
	 <20060815183310.284d03ae.lista1@comhem.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/06, Voluspa <lista1@comhem.se> wrote:
>
> Pointer freezing would be Dmitry's domain, but he'd have to work with
> someone who can trigger it easily, and who can write scripts to capture
> debug data, since it's 'hard' to move a frozen pointer to a terminal
> and issue commands...
>

The trick is to have a terminal open and then do alt-tab (presuming
that it does not unfreeze the pointer)...

-- 
Dmitry
