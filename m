Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbVAEIOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVAEIOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 03:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVAEIOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 03:14:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26053 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262297AbVAEIOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 03:14:19 -0500
Date: Wed, 5 Jan 2005 08:14:15 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: krishna <krishna.c@globaledgesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <lkml@kolivas.org>
Subject: Re: How to write elegant C coding
Message-ID: <20050105081415.GH26051@parcelfarce.linux.theplanet.co.uk>
References: <41DB8CC3.3040305@globaledgesoft.com> <2cd57c90050104234934ab6201@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c90050104234934ab6201@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 03:49:07PM +0800, Coywolf Qi Hunt wrote:
> I'd say better to study compile theory and a kind of compiler source code.

Yes, gcc source definitely makes a great cautionary tale about the need of
writing elegant code and dreadful results of not doing so.
