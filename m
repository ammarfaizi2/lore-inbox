Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTFKUhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFKUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:36:51 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:51376 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264454AbTFKU0v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:26:51 -0400
Subject: Re: Build problems with Linux 2.5
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Jay Denebeim <denebeim@deepthot.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
References: <Pine.LNX.4.44.0306101427260.13724-100000@dent.deepthot.org>
Content-Type: text/plain
Message-Id: <1055364034.17154.93.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 13:40:34 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 13:26, Jay Denebeim wrote:

>   The problem I'm having seems to be related to modutils.

You need to use module-init-tools.

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

Read the docs before you build and install it, so that it continues to
work with modutils.

	<b

