Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVCJItX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVCJItX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 03:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbVCJItX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 03:49:23 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:12383 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262435AbVCJItU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 03:49:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=mKBXDM9FUDfXmkeDpMkCv/cXnoYx3Ll6PXIYklNdL2IYtaDULbq6iJDxXIAgaAxSND85wQYliPYHwnqVRR53hPoI4OypCxG+sZP0NiNl4WbGzLT6Q/3ciM3uGqX8xFzRbYJ51jV0UDF8wgsZV7DgQq1+DEoAJP020CQ9QIvFUEM=
Message-ID: <c4b38ec40503100049190d5498@mail.gmail.com>
Date: Thu, 10 Mar 2005 16:49:20 +0800
From: Jason Luo <abcd.bpmf@gmail.com>
Reply-To: Jason Luo <abcd.bpmf@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Can I get 200M contiguous physical memory?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050310081634.GA29516@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <c4b38ec4050310001061c62b9d@mail.gmail.com>
	 <20050310081634.GA29516@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks!
A data acquisition card. In DMA mode, the card need 200M contiguous
memory for DMA.
it's driver in windows can do it. so custom ask us to support it.
are there a way although it'is unpopular?

On Thu, 10 Mar 2005 00:16:34 -0800, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Mar 10, 2005 at 04:10:18PM +0800, Jason Luo wrote:
> 
> > Now, I am writing a driver, which need 200M contiguous physical
> > memory? can do? how to do it?
> 
> Not easily no.  Do you really need this?  What kind of hardware is
> this?
>
