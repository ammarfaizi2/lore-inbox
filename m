Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWF0UWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWF0UWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWF0UWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:22:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:22177 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030344AbWF0UWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:22:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k1CIYLai+OfkhWTVaBKRnabeLRRI4/CyvcPxjp8VFw2fL3+CYN79vE5YOOPAgS1Yp4zwzlto0HlUys78s4dDmdoVt5sxou6fqQaOS9AqDbTzb8D7xoI8++HnIaptB38JR7JQfTVs2OhgpnRJiQvYyJCwM951tAjx2pdGYP2stEw=
Message-ID: <bda6d13a0606271322x6f2d76f4wfdbc885062d9a145@mail.gmail.com>
Date: Tue, 27 Jun 2006 13:22:35 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: klibc and what's the next step?
In-Reply-To: <44A16E9C.70000@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <klibc.200606251757.00@tazenda.hos.anvin.org>
	 <p73r71attww.fsf@verdi.suse.de> <44A166AF.1040205@zytor.com>
	 <200606271940.46634.ak@suse.de> <44A16E9C.70000@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I currently use it as a replacement for initrd that uses approx 1/2
the RAM (maybe less when I get around to changing CONFIG_MINIX_FS to
module).

I couldn't care less about kinit right now as I run dash there, but it
could be useful if root= support is removed.

BTW, is there a kinit= kernel command line so I can spawn an
interactive shell rather than /init?  init= doesn't do it.
