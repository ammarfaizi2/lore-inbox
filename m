Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVD2Fsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVD2Fsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVD2Fsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:48:32 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:20826 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262391AbVD2Fsb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:48:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lwc6bAbIX4soVVuDGtPuYausE8lCDa9OJySsyxIKYqV1qjhaaBJF8TYmySIaq+g2Pk7GAYLeEV927jsXqftDIY8thEgKc/NZrAd+4CGEgRtVxNnEOM4qT7QPvtHqvVMXt8mboVmJ0Ytwye3hz6Teo123q4ymp66gqIWK+lxppzg=
Message-ID: <ba8358220504282248344d5e78@mail.gmail.com>
Date: Thu, 28 Apr 2005 22:48:31 -0700
From: Gilles Pokam <gpokam@gmail.com>
Reply-To: Gilles Pokam <gpokam@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Kernel memory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429054351.GA12654@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ba83582205042816522e2a7a93@mail.gmail.com>
	 <20050429030313.GA10344@taniwha.stupidest.org>
	 <ba8358220504282233754de43b@mail.gmail.com>
	 <20050429054351.GA12654@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Apr 28, 2005 at 10:33:16PM -0700, Gilles Pokam wrote:
> 
> > I was thinking of making the whole memory accessible to handle this.
> > But I can not rely on mapping /dev/mem or /proc/kcore into the user
> > space since this would require modifying the binary. Are there other
> > ways of doing this ? May be disabling paging ? if so, how to do this
> > ?
> 
> why can't you use a wrapper?

Can you be more explicit ?

Thanks.

Gilles
