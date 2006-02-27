Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWB0WbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWB0WbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWB0WbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:31:07 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:15758 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751750AbWB0Way convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:30:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kPayodhhfjxYtv3pBI/FYL36La8ZRbAN+bvWHVdQYEQPYAd0eIi62NbnNh3kKLR91OKSpU5i9fWYNwQrd9JOxM7kkpcebc4PbJyKVDitmAyL80u1OzJNIJV6DiCznSHBfxPfL7Jl6l+YHx0Fbv1OY/tl/TvWgF9OOpE9lFSV3yw=
Message-ID: <7e90c9180602271430m35051882jcc3e5b1608fb6be9@mail.gmail.com>
Date: Mon, 27 Feb 2006 14:30:53 -0800
From: "Peter Gordon" <codergeek42@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200602271647.48600.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fa.deNPP6WI8uOxYJJt5IRsDHJHqNc@ifi.uio.no>
	 <20060227212141.GA1334769@hiwaay.net>
	 <200602271647.48600.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, D. Hazelton <dhazelton@enter.net> wrote:
> This value is also reported by the drive. I don't know about DVD drives, but
> for CD drives it is a multiplier. 1x == 256K/sec transfer off the disc [...]
For CDs, 1x is actually 150 KByte/sec.

> I haven't had time to look into the DVD specification, but I'm guessing that
> the DVD speed is about 3x what the CDROM speed is.

According to WikiPedia, the DVD speed rating is almost 9 times that of
CD speeds. I.e., 1x DVD is about 1.32 MByte/sec.


Just to make sure that we're all on the same page. :)
~~Peter
