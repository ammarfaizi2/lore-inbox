Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbUKAN7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbUKAN7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 08:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbUKAN7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 08:59:16 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:58711 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S264603AbUKANzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 08:55:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=dntbWIHEBh8fe9X+btLwsiYoWMGC8ATyQUA2KAkxg6eNsVszt4eYjvqVth3E5eaB++C92CAp9ZHDtsnyVlbcbLQW9+wdUAHLzI5TOuPZ15nT9tXE/agSjRnI6FJforgjX4TLukMdnFJx+kFRuYrsKeTfT68tiMW8FVGKBEQlCX8=
Message-ID: <35fb2e590411010555186f03a1@mail.gmail.com>
Date: Mon, 1 Nov 2004 13:55:32 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Bijoy Thomas <bijoyjth@gwu.edu>
Subject: Re: set blksize of block device
Cc: Lei Yang <lya755@ece.northwestern.edu>, linux-kernel@vger.kernel.org,
       kernelnewbies <kernelnewbies@nl.linux.org>
In-Reply-To: <55dddd455db643.55db64355dddd4@gwu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <55dddd455db643.55db64355dddd4@gwu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004 23:34:08 -0400, Bijoy Thomas <bijoyjth@gwu.edu> wrote:

> You set the blocksize for block device when you format it.

Just to clear this up for the archives, it's worth explaining the
difference between the various block sizes mentioned - the poster was
referring to hardware block size (e.g. sector size on a hard disk) and
not to the size used within a particular filesystem.

Jon.
