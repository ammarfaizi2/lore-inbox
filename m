Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVLPF3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVLPF3Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 00:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVLPF3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 00:29:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57732 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932135AbVLPF3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 00:29:16 -0500
Date: Fri, 16 Dec 2005 00:29:13 -0500
From: Dave Jones <davej@redhat.com>
To: Alex Davis <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051216052913.GD30754@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051216052054.83256.qmail@web50209.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051216052054.83256.qmail@web50209.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 09:20:54PM -0800, Alex Davis wrote:
 > The problem is that, with laptops, most of the time you DON'T have a choice:
 > HP and Dell primarily use a Broadcomm integrated wireless card in ther products.
 > As of yet, there is no open source driver for Broadcomm wireless.

We've already been through all this the previous times this came up.

http://bcm43xx.berlios.de

Whilst it's in early stages, it's making progress.

		Dave

