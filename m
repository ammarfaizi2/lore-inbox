Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWGXODY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWGXODY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 10:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWGXODX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 10:03:23 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:36766 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S932172AbWGXODX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 10:03:23 -0400
Subject: Re: [PATCH] Add maintainer for memory management
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <clameter@sgi.com>, linux-mm@kvack.org
In-Reply-To: <1153713707.4002.43.camel@localhost.localdomain>
References: <1153713707.4002.43.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 16:03:15 +0200
Message-Id: <1153749795.23798.19.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

The way I understand the maintainership of the memory management code is
as follows: there is explicitly no maintainer listed. This code is so
sensitive and has interactions with so many other sub-systems that it
would not be doable to look at it from all possible angles by only one
person.

As it stands its more a group of people headed by Linus, Andrew and
Hugh.

Peter


