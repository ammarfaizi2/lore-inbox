Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVFTXKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVFTXKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 19:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVFTXGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 19:06:50 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:16570 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261838AbVFTXGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 19:06:25 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Date: Tue, 21 Jun 2005 01:06:38 +0200
User-Agent: KMail/1.8.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jan malstrom <xanon@snacksy.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <42B6BEC2.405@snacksy.com> <200506202341.19426.bero@arklinux.org> <20050620224544.GF4562@in.ibm.com>
In-Reply-To: <20050620224544.GF4562@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506210106.39197.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 June 2005 00:45, Dipankar Sarma wrote:
> > > > > > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> Did you too see the problem with KDE userland ? It
> always seem to happen with kded doing fcntl() or fcntl64().

Yes, looks like the same thing.

LLaP
bero
