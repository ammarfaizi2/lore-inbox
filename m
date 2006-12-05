Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937356AbWLEGkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937356AbWLEGkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 01:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937358AbWLEGkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 01:40:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58897 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937356AbWLEGkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 01:40:21 -0500
From: =?UTF-8?Q?Kristian_H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 0/2] fw-core resend
Date: Tue, 05 Dec 2006 01:36:41 -0500
To: linux-kernel@vger.kernel.org
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>
Message-Id: <20061205063641.9320.44707.stgit@dinky.boston.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, looks like the fw-core patch was to big for the list.  I've
split it into two parts: fw-core which is the transaction logic and
bus reset handling and fw-device which is device probing and sysfs
integration.

cheers,
Kristian
