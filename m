Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUF3UzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUF3UzQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUF3UzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:55:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7627 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262744AbUF3UzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:55:09 -0400
Date: Wed, 30 Jun 2004 13:55:05 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: s390(64) per_cpu in modules (ipv6)
Message-Id: <20040630135505.5e1fcb4d@lembas.zaitcev.lan>
In-Reply-To: <20040630130442.GA2440@mschwid3.boeblingen.de.ibm.com>
References: <20040630130442.GA2440@mschwid3.boeblingen.de.ibm.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2004 15:04:42 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> The solution is the "X" constraint.

What is the minimum gcc version which supports "X" constraint?

Thanks,
-- Pete
