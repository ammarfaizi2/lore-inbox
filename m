Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264934AbSKRTnP>; Mon, 18 Nov 2002 14:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSKRTmp>; Mon, 18 Nov 2002 14:42:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29701 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264903AbSKRTmZ>;
	Mon, 18 Nov 2002 14:42:25 -0500
Message-ID: <3DD94423.1010503@pobox.com>
Date: Mon, 18 Nov 2002 14:48:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ducrot Bruno <poup@poupinou.org>
CC: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RTL8139D support for 2.4?
References: <3DD8B521.19184544@eyal.emu.id.au> <3DD931BA.9040407@pobox.com> <20021118193248.GE27595@poup.poupinou.org>
In-Reply-To: <3DD8B521.19184544@eyal.emu.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ducrot Bruno wrote:

> Do we have to assume that Eyal Lebedinsky should use 8139cp driver
> instead of 8139too ?



If it is definitely 8139D chip, then no.  That is a continuation of the 
"old 8139" line of chips.

But, we cannot know for sure until we see an lspci output :)

