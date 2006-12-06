Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760262AbWLFGjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760262AbWLFGjt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760264AbWLFGjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:39:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34633 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760262AbWLFGjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:39:49 -0500
Date: Tue, 5 Dec 2006 22:39:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
Message-Id: <20061205223945.8c81ea91.akpm@osdl.org>
In-Reply-To: <20061205172512.GA5518@m.safari.iki.fi>
References: <20061205172512.GA5518@m.safari.iki.fi>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 19:25:13 +0200
Sami Farin <7atbggg02@sneakemail.com> wrote:

> [1.] PROBLEM: 2.6.19 + highmem = BUG at do_wp_page 

Can you send the .config please?
