Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUD2CBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUD2CBr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 22:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUD2CBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 22:01:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:53398 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262850AbUD2B6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:58:51 -0400
Date: Wed, 28 Apr 2004 18:57:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rik van Riel <riel@redhat.com>
Cc: brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428185720.07a3da4d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
References: <20040428180038.73a38683.akpm@osdl.org>
	<Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@redhat.com> wrote:
>
>  IMHO, the VM on a desktop system really should be optimised to
>  have the best interactive behaviour, meaning decent latency
>  when switching applications.

I'm gonna stick my fingers in my ears and sing "la la la" until people tell
me "I set swappiness to zero and it didn't do what I wanted it to do".

