Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760506AbWLFLnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760506AbWLFLnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 06:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760499AbWLFLnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 06:43:06 -0500
Received: from mail.tbdnetworks.com ([204.13.84.99]:43547 "EHLO
	mail.tbdnetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760506AbWLFLnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 06:43:05 -0500
Subject: Why is "Memory split" Kconfig option only for EMBEDDED?
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: TBD Networks
Date: Wed, 06 Dec 2006 12:42:29 +0100
Message-Id: <1165405350.5954.213.camel@titan.tbdnetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I remember reading on LKML some time ago that using VMSPLIT_3G_OPT would
be optimal for a machine with exactly 1GB memory (like my current
desktop). Why is that option only prompted for after selecting EMBEDDED
(which I normally don't select for desktop machines)?

Best,
  Norbert


