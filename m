Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbVIKWK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbVIKWK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbVIKWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:10:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19101 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750960AbVIKWK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:10:27 -0400
Date: Sun, 11 Sep 2005 15:09:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Trilight <trilight@ns666.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: oops occured by dentry being passed in is NULL
Message-Id: <20050911150945.3fc2ea35.akpm@osdl.org>
In-Reply-To: <432454B5.8040307@ns666.com>
References: <432454B5.8040307@ns666.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trilight <trilight@ns666.com> wrote:
>
> I justed installed 2.6.13.1 (vanilla) on several laptops and a desktop,
>  the result is an Oops during boot.

Please send .config.
