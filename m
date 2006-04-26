Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWDZSGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWDZSGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWDZSGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:06:51 -0400
Received: from pproxy.gmail.com ([64.233.166.183]:43706 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932351AbWDZSGu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:06:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jt2EFZHEfvfVw34A8tdOJrmn0O8PDA3ornM3WT8h5DQHWfxtFAL9gYJJHp3SHLg0Sy8EslcbgiPPr1t5LFQTJW/4N2X3q8ZdSCnra2VEFANg01CR3LWkp2dNFLUcSwMg6YziHWjEBHAFbW+UqfZoFb8R7Bbk8EoK02NBo5CbjdU=
Message-ID: <2f4958ff0604261106p20b3f505raf9800530178a802@mail.gmail.com>
Date: Wed, 26 Apr 2006 20:06:46 +0200
From: "=?ISO-8859-2?Q?Grzegorz_Ja=B6kiewicz?=" <gryzman@gmail.com>
To: "Randy. Dunlap" <rdunlap@xenotime.net>
Subject: Re: can't compile kernels lately (2.6.16.5 and up)
Cc: gryzman@gmail.com, opslynx@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060426103801.b05bec5d.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2f4958ff0604260639n4874c2aua1e99ec4c32d2182@mail.gmail.com>
	 <200604261102.12935.gene.heskett@verizon.net>
	 <2f4958ff0604260817l68235c77hb3430b2a800a96cf@mail.gmail.com>
	 <df47b87a0604260906m519cc6f5ud4d8527d4e5a243e@mail.gmail.com>
	 <2f4958ff0604260922l6441d6c1s72d327c0f0ff2318@mail.gmail.com>
	 <20060426093346.c36be5ff.rdunlap@xenotime.net>
	 <2f4958ff0604260938u759fdb53x950ca3cef34424e5@mail.gmail.com>
	 <20060426103801.b05bec5d.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did all that without errors.  I don't think it's a tarball
> problem at all.  It looks more like a toolchain problem.
>
> Were there any other errors or warnings, e.g., when
> scripts/mod/file2alias.c does
> #include "../../include/linux/input.h"
> does that generate any error or warning?
>
> I think that your last comment was closer to the real problem.
> All of the errors are related to input_device_id.
>
> What CPU architecture/type are you doing this on?
x86, pentim M toshiba laptop.


--
GJ
