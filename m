Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271016AbUJVKaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271016AbUJVKaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 06:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271017AbUJVKaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 06:30:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:9931 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271016AbUJVKaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 06:30:21 -0400
Date: Fri, 22 Oct 2004 03:28:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: kenneth.w.chen@intel.com, wli@holomorphy.com, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
Message-Id: <20041022032823.215bd95f.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
>  	* overcommit handling

What does this do, and why do we want it?
