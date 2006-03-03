Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751997AbWCCGii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWCCGii (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWCCGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:38:37 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:39155 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751997AbWCCGih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:38:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MdnAdXRfRxaX/CE7XzezJ8ow84NbGjXFgej0adU5OvKf+2qL+FZOn9SpB3NpLMUvnW0hMtF9BgReHiyVBQIJYfK1rKNOw9qj20M5p9havKJz3wQBi3IkmoYIcM5tDDSS9MQ1fvONa0NUgULqjT6QL7dlTxevjAQm3ox+0O9H5zQ=
Message-ID: <105c793f0603022238p6a3e0a7ex98aaa1affc54a325@mail.gmail.com>
Date: Fri, 3 Mar 2006 01:38:36 -0500
From: "Andrew Haninger" <ahaning@gmail.com>
To: "tim tim" <tictactoe.tim@gmail.com>
Subject: Re: modutils
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <503e0f9d0603022232r2990ae91l9e8efe46c72e18a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <503e0f9d0603022041q717ae7cdo8539ba8f508dd681@mail.gmail.com>
	 <105c793f0603022138u6dca326ewa3b5d476f4c4ef48@mail.gmail.com>
	 <503e0f9d0603022141l5dc9a88ds380dd9dd2ba22c41@mail.gmail.com>
	 <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com>
	 <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com>
	 <105c793f0603022205j124a9d19qab33c34e9750d5c9@mail.gmail.com>
	 <503e0f9d0603022215h7632d8d9w7c278cd70b02d662@mail.gmail.com>
	 <105c793f0603022227m3523a8f1vf1371d3eebe1553e@mail.gmail.com>
	 <503e0f9d0603022232r2990ae91l9e8efe46c72e18a8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Again, hope you don't mind the Cc.

On 3/3/06, tim tim <tictactoe.tim@gmail.com> wrote:
> can u refer me any website for modinit tools downloading.. and related
> study informaiton on thar..
You can download module-init-tools at
http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/ or
most any Linux kernel mirror (see kernel.org for mirrors and other
general Linux information).

I don't really know of any good information sites for
module-init-tools. There should be a README in the source package.
Some simple web searches should produce decent information, or at
least a starting point.

-Andy
