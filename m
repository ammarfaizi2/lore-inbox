Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVBGKix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVBGKix (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 05:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVBGKix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 05:38:53 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:49156 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261394AbVBGKiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 05:38:50 -0500
Date: Mon, 7 Feb 2005 11:38:42 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Pavel Fedin <sonic_amiga@rambler.ru>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Generating NLS modules
Message-ID: <20050207103842.GA2686@pclin040.win.tue.nl>
References: <20050207091038.606d9f0e.sonic_amiga@rambler.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050207091038.606d9f0e.sonic_amiga@rambler.ru>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: kweetal.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 09:10:38AM -0500, Pavel Fedin wrote:

>  Nobody answered so i repeat the question.
>  I think i found a way to make use of NLS table for HFS filesystem and
> i'm going to try to implement it. But first i need to create NLS module
> for codepage 10007 (Mac cyrillic). In the beginning of every existing
> NLS module code i see comment which says that this file is automatically
> generated from data found at unicode.org. Could you tell me where i can find a
> convertor and what data it can use as input? I explored unicode.org and found
> some conversion data at oss.software.ibm.com/icu/. The data is available in
> UCM and XML formats. Are those files suitable?

Last week or so I regenerated three NLS modules.
Used a small thrice-only throwaway script.
Don't know who generated the NLS modules first, or
what software was used.
