Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVBXAQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVBXAQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVBXAQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:16:03 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9619 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261673AbVBXAP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 19:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eV2gnWRReDrPYk7QtDlUeWOx9/K7xfh6I/I8ZWzxS0XmwmQ2MZQesjbEzepuRK+qv5D49XbgaVBOoYQScaEuVTzVvrEBbtHsfEt8bZbrMwlXFlItErhCt5YGW6h6qlARjNt3VnO0bciIZj5KucmV05jILEfC6flL+hJEYqRYNuU=
Message-ID: <7d92433305022316013e802bd1@mail.gmail.com>
Date: Wed, 23 Feb 2005 19:01:19 -0500
From: Dan Sturtevant <sturtx@gmail.com>
Reply-To: Dan Sturtevant <sturtx@gmail.com>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: fork/clone external to a process?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041225222625.GB27315@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <7d92433304122107491b8b624a@mail.gmail.com>
	 <41C8B128.7010201@xs4all.nl>
	 <7d92433304122116361c2933fb@mail.gmail.com>
	 <20041225222625.GB27315@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> gdb attach the vmware, then force it to call routine you preloaded...
> 
> Or look at subterfugue.
>                                                                 Pavel

Brilliant Pavel.  Thank you.  gdb works great.

Dan
