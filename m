Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUA0VMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUA0VMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:12:46 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:54913
	"EHLO cheetah") by vger.kernel.org with ESMTP id S265267AbUA0VMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:12:45 -0500
Date: Tue, 27 Jan 2004 13:05:04 -0800
From: "David S. Miller" <davem@redhat.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/sha256.c crypto/sha512.c
Message-Id: <20040127130504.1c760026.davem@redhat.com>
In-Reply-To: <20040127202225.GA15808@certainkey.com>
References: <20040127193945.GA15559@certainkey.com>
	<Xine.LNX.4.44.0401271514150.4185-100000@thoron.boston.redhat.com>
	<20040127202225.GA15808@certainkey.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jan 2004 15:22:25 -0500
Jean-Luc Cooke <jlcooke@certainkey.com> wrote:

> The Ch() and Maj() operations are used a lot in sha256/512.

Your analysis is great, but James was really asking for numbers :-)
