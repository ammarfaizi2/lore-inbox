Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbUC3JIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUC3JIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:08:30 -0500
Received: from [217.93.26.36] ([217.93.26.36]:31925 "EHLO stigge.org")
	by vger.kernel.org with ESMTP id S263554AbUC3JIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:08:22 -0500
Subject: tg3 problems with NFS
From: Roland Stigge <stigge@antcom.de>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, jgarzik@pobox.com
Content-Type: text/plain
Organization: Antcom
Message-Id: <1080637698.1982.9.camel@atari.stigge.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 30 Mar 2004 11:08:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encountered some problems with the tg3 network device driver in the
2.6 kernel series, namely problems when using the device for nfs.

For further description, see

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=240812

I checked it with the 2.6.5-rc3 kernel, and the issue is still present.
Please tell me how I can help debugging this further.

Thanks for considering.

bye,
  Roland


