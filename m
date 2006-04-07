Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932313AbWDGHJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932313AbWDGHJw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 03:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWDGHJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 03:09:52 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:6629 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932313AbWDGHJw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 03:09:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PF65Mcg9jk6ODeOSKxlqatNvHW7m7Jljj3OSQ38NgTb23Q/J5CMYu7B0ryI9FT24fBv09WdJ36G6VlDBVpTNzHX4oVIHdKVWK9rV0DiyglX6tkKIZGgWKxmABfWabojkz0iLbQ2W0LIn4LZ3nLuEd27ylVpBWgRGoQ+3KrYJnvE=
Message-ID: <bda6d13a0604070009x59c1517bw28c2f4f5e24ffe96@mail.gmail.com>
Date: Fri, 7 Apr 2006 00:09:51 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: wait4/waitpid/waitid oddness
In-Reply-To: <17462.3003.229525.874004@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
	 <bda6d13a0604061909u69dd8453me4c9b96cca8d34f5@mail.gmail.com>
	 <217AB2B7-BD72-49BE-AB02-AA952728073B@mac.com>
	 <bda6d13a0604062340p5f5ff496u20c7f6135284b43f@mail.gmail.com>
	 <17462.3003.229525.874004@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wonder what you are doing about the conceptual problem of
>   What does ".." mean now?
>
> NeilBrown
dnode->d_parent.
