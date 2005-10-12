Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbVJLUAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbVJLUAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbVJLUAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:00:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751523AbVJLUAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:00:11 -0400
Date: Wed, 12 Oct 2005 12:59:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: schwidefsky@de.ibm.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc4-git] s390, ccw - export modalias
Message-Id: <20051012125939.6ee58910.akpm@osdl.org>
In-Reply-To: <20051012192639.GA25481@wavehammer.waldi.eu.org>
References: <20051012192639.GA25481@wavehammer.waldi.eu.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bastian Blank <bastian@waldi.eu.org> wrote:
>
> This patch exports modalias for ccw devices.

And why do we want to do that?
