Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965224AbWECPde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965224AbWECPde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWECPde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:33:34 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:40390 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965224AbWECPdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:33:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FJ6YeROVbUHaSifhVT7J9sb4VCYDP1aDyw8w4Kjvf4CrLqZaWTXQepbU0VXKMmRvU7AORA+pJ//qbvqe9es4bQcZPNJuvd+ofRaqZ5FNDokR8qO1gpL7X1n5PNzgBnI5+gDNX4LmPYVj8i6GzeDN2r/1Y0DfAjRP0HhRfLEOEH0=
Message-ID: <6934efce0605030833w470ac1e1s6048548b699fd082@mail.gmail.com>
Date: Wed, 3 May 2006 08:33:33 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "Mark Lord" <lkml@rtr.ca>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4458A70E.603@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <4458A70E.603@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this stable enough for production use now?

No.  It barely mounts.  I do think it should prove fairly stable
quickly but it will be a while before I'd use it for production.
