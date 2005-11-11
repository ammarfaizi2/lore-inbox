Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVKKWcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVKKWcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 17:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbVKKWcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 17:32:52 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:9480 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751276AbVKKWcw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 17:32:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WCGmuszZICMWPyUsls0UB7dIXF1vvnH+ilxLvJSE5MEWLaDoKP9XkHhaQXoO9gr59AqWLZSKmt2Z89DOwDI31kdjqH/yg6G2f4Jc6FsoIzLpH08cugXFQ0uECbgfP23wP900EotTLuFBnUnsdIdlaMoyg97qAh44rpdxDVKm0XQ=
Message-ID: <6bffcb0e0511111432m771dcda2y@mail.gmail.com>
Date: Fri, 11 Nov 2005 23:32:49 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051110203544.027e992c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/11/05, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
>

Something is broken with nvidia framebuffer. When I try to login on
tty1 "Password: " doesn't appear. It appear when I switch Alt+F2 to
tty2 and then back to tty1.

Regards,
Michal Piotrowski
