Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbUKTXrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbUKTXrv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 18:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUKTXqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 18:46:10 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:52819 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263200AbUKTXh5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 18:37:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=fD8RO1WxxrGgKPGf6Y7zpLLgLWGw3nsy+Dr2Ih1NYhRt/ov2Z6i1MGxqsas9L8xKkGDptKedVAe2o8O6fUuem0pS/BN8KD7zOVuyCVAj8byUmL66MwOROl+pghL+bfeZWHy5JtbVJnMPuz/8iTWWLTcoMlKwTcjcoQLabTnkrOs=
Date: Sun, 21 Nov 2004 00:37:55 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/13] Filesystem in Userspace
Message-Id: <20041121003755.3342a1cb.diegocg@gmail.com>
In-Reply-To: <E1CVeML-0007PA-00@dorka.pomaz.szeredi.hu>
References: <E1CVeML-0007PA-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 21 Nov 2004 00:09:37 +0100 Miklos Szeredi <miklos@szeredi.hu>
escribió:

[...]
>     - adds /sys/fs/fuse/version

If FUSE is going to be included in the kernel, would you really need that?
 
If something it's in mainline "kernel version 2.6.56" is enought to describe
what code people are running.
