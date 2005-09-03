Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbVICGZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbVICGZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbVICGZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:25:57 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:27209 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161164AbVICGZ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:25:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KhEVFLW1nypeIK4nTlbQ43ddA43fkOSgtkRkD5QC6/2TxW93a1NeB2tqhN3J2+8nGZZ7I9B7WroP150b4ctbp3pR8b5kWmp+HFNkTWMj6vlshlSFxGIyPufmEmlZgqmlefzXmu7F7b4K5zpenLJOB58p7QmHR8DASTY3rEDhXbs=
Message-ID: <355e5e5e05090223259e47cf6@mail.gmail.com>
Date: Fri, 2 Sep 2005 23:25:53 -0700
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: lkosewsk@gmail.com
To: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: Re: Hotswap support for libata
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <355e5e5e05090223231726b94a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902224418.78897.qmail@web32512.mail.mud.yahoo.com>
	 <355e5e5e05090223231726b94a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a happier note, once the infrastructure is accepted, anyone with a
hotswap-unsupported controller and some time on their hands will
easily be able to integrate hotswap in; that is the whole goal of an
infrastructure.  So if your controller isn't supported, but you know
something about it (or better yet, you yourself have docs), adding
hotswap support to it should be too hard.

Luke Kosewski
