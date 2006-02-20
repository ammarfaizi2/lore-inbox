Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932695AbWBTIBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbWBTIBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 03:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWBTIBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 03:01:01 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:36207 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932695AbWBTIBA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 03:01:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VuM8gVixa653raqW5dNLNcP0d4wca7ERl7T69gOiXB4jK2C9O3tEdg2PB6Wtr0yZcscysbaDwUwgx0ggqzlNGQ3z9UcFaIiq5EA9MThGTs5yLrpeM/Xli3o9HeOF2nJFJHg+hcJqBU92p4q5A0arSI44WKv/7k9j6bNYA0OMZFg=
Message-ID: <4807377b0602200000u6c7216a6pfd66aef0e6956054@mail.gmail.com>
Date: Mon, 20 Feb 2006 00:00:57 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602191835460.7212@p34>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602191807001.7212@p34>
	 <Pine.LNX.4.64.0602191835460.7212@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> /usr/src/linux/Documentation//networking/e1000.txt:the issue to
> linux.nics@intel.com.
>
> ^^ That e-mail is invalid, someone should make a diff/patch to remove it
> and update it if there is a correct one or just remove it entirely.
>
> Justin.
>
> As of 2.6.15.3 source.

Agreed, I have an update pending in my queue but got lost in git-land
