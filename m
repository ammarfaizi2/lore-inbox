Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWHYVmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWHYVmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 17:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWHYVmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 17:42:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751502AbWHYVmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 17:42:25 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060824182006.GD17658@us.ibm.com> 
References: <20060824182006.GD17658@us.ibm.com>  <20060824181722.GA17658@us.ibm.com> 
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] eCryptfs: Open-code flag manipulation 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Fri, 25 Aug 2006 22:42:08 +0100
Message-ID: <7194.1156542128@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:

> Open-code flag checking and manipulation.

That looks reasonable.

Acked-By: David Howells <dhowells@redhat.com>
