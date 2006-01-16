Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWAPOQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWAPOQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 09:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAPOQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 09:16:37 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:14301 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750818AbWAPOQh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 09:16:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oYrXGhNd5paTqnubmHd3xxBV9MUh9jidLvN/Jgw9k6DFjck43wCZwXo2/1ybBFeMVuc4//V0fGiqn8ZGbYdNS6Y2wtj8fOB+FLhO559XApMluITzvWb59lYOBDZm9rvYwiTrEK9LysDn1HU57WoKFa7r6lvacsSujk48hsTX0J0=
Message-ID: <9a8748490601160616i35fa2a6fv693d8ecc84133d5f@mail.gmail.com>
Date: Mon, 16 Jan 2006 15:16:36 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 1/3] makes print_symbol() return int
Cc: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20060116121706.GB539@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060116121611.GA539@miraclelinux.com>
	 <20060116121706.GB539@miraclelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/06, Akinobu Mita <mita@miraclelinux.com> wrote:
> This patch makes print_symbol() return the number of characters printed.
>
Why?
Who are the users of this?
If there are users who can bennefit, then where's the patch to make
them use this new return value?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
