Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTH1VV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTH1VV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:21:57 -0400
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208]:8894 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264282AbTH1VV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:21:56 -0400
Subject: [ANNOUNCE] netplug, a daemon that handles network cables getting
	plugged in and out
From: "Bryan O'Sullivan" <bos@keyresearch.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 28 Aug 2003 14:21:52 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Netplug is a daemon that responds to network cables being plugged in or
out by bringing a network interface up or down.  This is extremely
useful for DHCP-managed systems that move around a lot, such as laptops
and systems in cluster environments.

For more details and download instructions, see the netplug homepage:
http://www.red-bean.com/~bos/

	<b

