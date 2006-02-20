Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWBTVbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWBTVbL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWBTVbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:31:11 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:22300 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbWBTVbK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:31:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/Q7G2u91i04kBDax0ZRRR1gZ87gMW3kofAlFzAlObyq+S/1MXn/LpfazgJt03CsgQF00cGhXXlo/L4K8tOBhTsefN1uavtWFdR5rgzX0a2xvdnQomN0C3QCyFFlXnH9w4ItwcLWKIyEE4cs4mJ+HaWGwMFglUEIO0qsfVQP18U=
Message-ID: <29495f1d0602201330i78d5538bwe4c771593f09ea97@mail.gmail.com>
Date: Mon, 20 Feb 2006 13:30:59 -0800
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>
Subject: Re: Mozilla Thunderbird posting instructions wanted
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060220210349.GA29791@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> This  POS is pretty popular among kernel janitors, so, can someone who
> is successfully using it, please, post crystally clear step-by-step
> instructions on how to send a foo.patch:
>         inline
>         with tabs preserved
>         with long lines preserved
>
> Sending plain text attachments is OK with me, but, heh, people do post
> patches inline and screw themselves.

Randy D. eventually agreed that there was a way, IIRC:

http://lkml.org/lkml/2005/12/27/191

Probably can work your way through the thread to figure out how (I use mutt :)

Thanks,
Nish
