Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbTJJIMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbTJJIMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:12:46 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:61312 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262597AbTJJIMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:12:46 -0400
Date: Fri, 10 Oct 2003 09:13:45 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310100813.h9A8DjB7000640@81-2-122-30.bradfords.org.uk>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
Subject: Re: [2.7 "thoughts"] V0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * kernel web server (Interfaced to Roman config tool)

A Gopher server is much more suited to this - why bother with the
complexity of a web server just to allow remote access to
configuration info?  It also means that the remote device has to be
one that can deal with HTML.

Gopher would easily scale down to devices as simple as mobile phones,
wrist watches, and LCD panels easily, and be usable over a very slow
link.

John.
