Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUDATxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 14:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUDATxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 14:53:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:39895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263081AbUDATxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 14:53:05 -0500
Date: Thu, 1 Apr 2004 11:52:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-Id: <20040401115252.7cdb9d6f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404011443250.5589-100000@chimarrao.boston.redhat.com>
References: <20040401135920.GF18585@dualathlon.random>
	<Pine.LNX.4.44.0404011443250.5589-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
>  One of the main reasons for the mlock rlimit is so that
>  security conscious people can let normal users' gpg
>  mlock a few pages.

Could you please refresh-n-send the RLIMIT_MEMLOCK patch?
