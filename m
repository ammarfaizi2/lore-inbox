Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVDEUeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVDEUeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVDEUdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:33:52 -0400
Received: from palrel11.hp.com ([156.153.255.246]:4232 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262003AbVDEU1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:27:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16978.62622.80542.462568@napali.hpl.hp.com>
Date: Tue, 5 Apr 2005 13:27:10 -0700
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, amy.griffis@hp.com,
       tony.luck@intel.com, linux-ia64@vger.kernel.org, dwmw2@infradead.org
Subject: Re: [03/08] fix ia64 syscall auditing
In-Reply-To: <20050405164647.GD17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
	<20050405164647.GD17299@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 5 Apr 2005 09:46:48 -0700, Greg KH <gregkh@suse.de> said:

  Greg> -stable review patch.  If anyone has any objections, please
  Greg> let us know.

Nitpick: the patch introduces trailing whitespace.

Why doesn't everybody use emacs and enable show-trailing-whitespace? ;-)

	--david
