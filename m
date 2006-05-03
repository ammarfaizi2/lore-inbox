Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbWECPbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbWECPbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWECPbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:31:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:53641 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965222AbWECPbv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:31:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qtxy3MPxnjCC5fcknjlv/0JL2ykZ4vxy/ubCQH3BXCUu9jwwOZ4PUDazheIENA0C7qJ3gujP8bZ1h4KHIaPQQRnoSyTirTu8AUGomTDTRW227TwltSocumSZ8LreSGbDT0BaivK/fUq3fE7nr0Qawhbm8/BoETxGRXi4pJFBu9E=
Message-ID: <6934efce0605030831h30d7e4e3hb057fd1b3f7791d3@mail.gmail.com>
Date: Wed, 3 May 2006 08:31:50 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060503130502.GD19537@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <20060503130502.GD19537@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o Document the on-medium format

Right.  Working on that.

> o Consider saving a zlib workspace by moving it out of your code and
>   sharing the infrastructure with cramfs and jffs2

Hmmm.  Can you explain what you mean by this.  That would require
modifying each of the 3 filesystems.
