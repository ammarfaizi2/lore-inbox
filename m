Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbUKXKjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUKXKjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbUKXKjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:39:40 -0500
Received: from news.suse.de ([195.135.220.2]:63946 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262600AbUKXKjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:39:39 -0500
Date: Wed, 24 Nov 2004 11:39:26 +0100
From: Andi Kleen <ak@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       jgarzik@pobox.com, alan@redhat.com, david.balazic@hermes.si,
       hpa@zytor.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] EDD: add edd=off and edd=skipmbr options
Message-ID: <20041124103926.GA10495@wotan.suse.de>
References: <20041123230001.GE30452@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123230001.GE30452@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter, Andi: I've built this for x86 and x86-64, and run this on x86.
> I'd appreciate your review of the assembly code, and suggestions for
> improvement, prior to my submitting it to akpm for 2.6.11.

Looks ok to me.

-Andi
