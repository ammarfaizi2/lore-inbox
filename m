Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbWAQXzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbWAQXzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWAQXzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:55:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50646 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932526AbWAQXzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:55:49 -0500
Date: Tue, 17 Jan 2006 18:55:21 -0500
From: Dave Jones <davej@redhat.com>
To: pfg@sgi.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.16rc1 ia64 missing symbol..
Message-ID: <20060117235521.GA14298@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, pfg@sgi.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/drivers/serial/ioc3_serial.ko needs unknown symbol ioc3_unregister_submodule

CONFIG_SERIAL_SGI_IOC3=m
CONFIG_SGI_IOC3=m

		Dave

