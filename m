Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271302AbTHRGVi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271307AbTHRGVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:21:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12522 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271302AbTHRGVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:21:37 -0400
Date: Sun, 17 Aug 2003 23:14:53 -0700
From: "David S. Miller" <davem@redhat.com>
To: Val Henson <val@nmt.edu>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bk patches] add ethtool_ops to net drivers
Message-Id: <20030817231453.6a31c98a.davem@redhat.com>
In-Reply-To: <20030818061511.GA1255@speare5-1-14>
References: <20030818061511.GA1255@speare5-1-14>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 00:15:11 -0600
Val Henson <val@nmt.edu> wrote:

> I needed the following patch to compile netsyms.c - just a missing
> include.

It's already in Linus's tree.
