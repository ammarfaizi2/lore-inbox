Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVACDav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVACDav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 22:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVACDau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 22:30:50 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:10621 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261287AbVACDar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 22:30:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=CoPzBMT4yhAp+WP58wpgLVuWVkp8hiHg9HNRzsnLKedWQJaMoruySCdgJdWrYS1csJz4AyqDUJ5zuJBwszSxfmDAWfNKOAy3BwhtoERwAS2PtUCBqwCfbGr1a8RnupCf0hdQQvLGWNYebWkuQJ40X8KmDgjLksgdXjnsXb+folU=
Message-ID: <53046857050102193079d2ee5f@mail.gmail.com>
Date: Sun, 2 Jan 2005 20:30:46 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
Reply-To: Jesse Allen <the3dfxdude@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Fix typo in i386 single step changes
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, davidel@xmailserver.org,
       mh@codeweavers.com, dan@debian.org
In-Reply-To: <m1brc7xv98.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <m1brc7xv98.fsf@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jan 2005 00:32:19 +0100, Andi Kleen <ak@muc.de> wrote:
> 
> Fix an obvious typo in the recent i386 single stepping changes.
> 
> I would recommend to redo all the Wine etc. testing that lead to this patch
> since it probably never worked.
> 

Well, even though it's unlikely it does anything, I tried the later
patch and everything is still OK.
