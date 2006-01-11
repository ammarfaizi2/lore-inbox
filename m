Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWAKAie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWAKAie (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 19:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWAKAie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 19:38:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22673 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030200AbWAKAic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 19:38:32 -0500
Date: Tue, 10 Jan 2006 16:19:38 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net, vojtech@suse.cz,
       stern@rowland.harvard.edu, mailing-lists-mmv@bretschneidernet.de,
       jengelh@linux01.gwdg.de, linux-usb-devel@lists.sourceforge.net,
       gregkh@suse.de, nouser@lpetrov.net, zaitcev@redhat.com
Subject: Re: PROBLEM: PS/2 keyboard does not work with 2.6.15
Message-Id: <20060110161938.68ad1947.zaitcev@redhat.com>
In-Reply-To: <20060111000151.GA5712@sith.mimuw.edu.pl>
References: <20060110074336.GA7462@suse.cz>
	<Pine.LNX.4.44L0.0601101008440.5060-100000@iolanthe.rowland.org>
	<20060110152807.GB22371@suse.cz>
	<d120d5000601100737r7b1e12edy6d4eedc4b12960fc@mail.gmail.com>
	<20060111000151.GA5712@sith.mimuw.edu.pl>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006 01:01:51 +0100, Jan Rekorajski <baggins@sith.mimuw.edu.pl> wrote:

> This happens on Dell Precision 380, [...]

Continue no further. What is the BIOS's A-version? Anything below A04
is unusable.

-- Pete
