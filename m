Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbUEWPSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUEWPSu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbUEWPSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:18:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26579 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262960AbUEWPSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:18:48 -0400
Message-ID: <40B0C0C7.9090604@pobox.com>
Date: Sun, 23 May 2004 11:18:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Christoph Hellwig <hch@alpha.home.local>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, alan@redhat.com,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: i486 emu in mainline?
References: <20040522234059.GA3735@infradead.org> <20040523082912.GA16071@alpha.home.local>
In-Reply-To: <20040523082912.GA16071@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
>   - There are people (like Alan) who think that this should not go into
>     mainline because this is a distro problem and nothing else. He says
>     that only i386 packages should be installed on an i386 machine. He's
>     perfectly right about this. I found it interesting for people like


I disagree.

I want to add "old Alpha" emulation code, so that older Alphas can run 
binaries built on the newer alphas.

	Jeff


