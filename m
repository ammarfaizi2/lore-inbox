Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVAELqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVAELqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 06:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVAELqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 06:46:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:402 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261633AbVAELqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 06:46:01 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <41DB4DAC.8060606@yahoo.com.au> 
References: <41DB4DAC.8060606@yahoo.com.au>  <17892.1104868588@redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Exclude PUD/PMD alloc functions if !MMU 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 11:45:30 +0000
Message-ID: <8091.1104925530@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> I think you need to do it in the following way:

That works too.

David
