Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWBMNjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWBMNjn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 08:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWBMNjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 08:39:43 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:61461 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750805AbWBMNjm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 08:39:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=omfoDPFds57f7aIEbLR/9Wob3YLg2mVF2OOAkEymt9XmJEHNVEe6cZqWnhJ33ibSCZN1wbRiO9Tfcey+NaE5yfgLELbY+mZ1bwh4H/cc4SQiDZHYLeyiMrf4V/xe8oqQwIib7c3nHxGFccuNiZgj188D0dZyFXKyANWyvm19imo=
Message-ID: <625fc13d0602130539x2845ab0ck7a7dc5bb7ef49d56@mail.gmail.com>
Date: Mon, 13 Feb 2006 07:39:38 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: "Victor Porton,,," <porton@ex-code.com>
Subject: Re: MTD for buffered IO
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1F8ZhY-0001fy-00@porton.narod.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1F8ZhY-0001fy-00@porton.narod.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Victor Porton,,, <porton@ex-code.com> wrote:
> I suggest to add kernel configuration/option to allow to use
> an MTD device as a continuation of I/O buffers (for HDD).
>
> One way to implement it would be to add the option for a swap partition/file to
> allow to use this swap partition/file as I/O buffer for other device.

I'm not quite sure what you mean here, but suggestions in the form of
patches go a lot further than just an email.

josh
