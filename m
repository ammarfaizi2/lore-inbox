Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVJCS1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVJCS1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVJCS1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:27:18 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:28395 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932497AbVJCS1R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:27:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/P7BLJEwSF8I2IlL7P8a2+sKBtdUhQ20tQA1Z9LfmCJ1irOrJ11AxdGROaLGPcpcZhfOyiKL+I8/+4cl02yVIL5jzZi2MFcG3J+voYADg4MoqTr8Faig1nYWf+NtvaQ8LubARpMhCuSqgYwQW28J4PntqZd2pAphO0kcDnJ63M=
Message-ID: <1af196280510031127l1189dcf7of2d39f0a1a658202@mail.gmail.com>
Date: Mon, 3 Oct 2005 14:27:16 -0400
From: Abhijeet More <abhijeet.more@gmail.com>
Reply-To: Abhijeet More <abhijeet.more@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: nforce3 lockup problem
In-Reply-To: <1af196280510021416m36cbdc22q3ae796698a49c561@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1af196280510021416m36cbdc22q3ae796698a49c561@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've found a solution to this:

On 10/2/05, Abhijeet More <abhijeet.more@gmail.com> wrote:

> I have a new system with an Asus K8N mainboard (nforce3 250 chipset)
> which locks up every time there
> is heightened hard disk activity.

A Bios update seems to have fixed this. It has passed all of my hard
drive activity tests (copying big files across filesystems, grep
etc.).
Regards
Abhijeet
