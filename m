Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFMSDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFMSDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFMSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:01:57 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:60231 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261173AbVFMSBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:01:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=mI1W6RHPcU+YqnhNGzv32+iHVW6vryBpJARRRiK0FRUFdgeQvtnondO53o9NKFVIwcZ15m+SwbdRNzO+H5MxtF7PmB6mfKEWmWUuCOq6iKruUW0q0/ZqQG7buj6KOnvrs7fI0d6AkF5VIJAoNJdGOsPbA65OIGTvORfoErVCGYc=
Subject: Re: A Great Idea (tm) about reimplementing NLS.
From: Islam Amer <pharon@gmail.com>
Reply-To: pharon@gmail.com
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42AD649E.1020901@stesmi.com>
References: <f192987705061303383f77c10c@mail.gmail.com>
	 <42AD649E.1020901@stesmi.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 21:01:20 +0300
Message-Id: <1118685680.18189.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
A related issue I had is that some codepages don't have a nls module
yet. 
For example I once or twice needed to mount a vfat filesystem with
cp1256 ( arabic windows ) charset. There is no such nls module. I
couldn't find any documentation about how to create the module ( maybe I
didn't look hard enough ).


