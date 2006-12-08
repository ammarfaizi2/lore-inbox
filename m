Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164361AbWLHBrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164361AbWLHBrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164367AbWLHBrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:47:04 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36999 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164361AbWLHBrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:47:02 -0500
Date: Thu, 7 Dec 2006 17:46:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: david singleton <dsingleton@mvista.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: new procfs memory analysis feature
Message-Id: <20061207174627.63300ccf.akpm@osdl.org>
In-Reply-To: <04710480e9f151439cacdf3dd9d507d1@mvista.com>
References: <45789124.1070207@mvista.com>
	<20061207143611.7a2925e2.akpm@osdl.org>
	<04710480e9f151439cacdf3dd9d507d1@mvista.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 17:07:22 -0800
david singleton <dsingleton@mvista.com> wrote:

> Attached is the 2.6.19 patch.

It still has the overflow bug.
