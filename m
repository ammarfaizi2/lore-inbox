Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVDYJws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVDYJws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 05:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVDYJws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 05:52:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28389 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262566AbVDYJwn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 05:52:43 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050423041607.GW4355@stusta.de> 
References: <20050423041607.GW4355@stusta.de> 
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/fscache/: cleanups 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 25 Apr 2005 10:51:40 +0100
Message-ID: <8303.1114422700@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:

> 
> This patch contains the following cleanups:
> - make needlessly global code static
> - main.c: remove the unused global variable fscache_debug

Please hold off on this patch. FS-Cache is going to change somewhat. I'll see
about including your suggestions in that.

David
