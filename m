Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264800AbUDUE5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbUDUE5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUDUE5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:57:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50590 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264800AbUDUE5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 00:57:14 -0400
Date: Tue, 20 Apr 2004 21:57:20 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Romain Lievin <lkml@lievin.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tiglusb: bug fixes (usb_clear_halt, usb_sndbulkpipe)
Message-Id: <20040420215720.4843421d.zaitcev@redhat.com>
In-Reply-To: <20040414183402.GA24976@lievin.net>
References: <20040414183402.GA24976@lievin.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2004 20:34:02 +0200
Romain Lievin <lkml@lievin.net> wrote:

> the first set of 2 patches (2.4 & 2.6) fixes 2 bugs:
>[...]
> ==========================[ src24 ]=============================

OK, this looks fine, but next time please do not mix 2.4 and 2.6
patches. I do not like to edit e-mails before applying.

-- Pete
