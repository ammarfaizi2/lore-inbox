Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUAYJDI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 04:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUAYJDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 04:03:08 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:64229 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S263787AbUAYJDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 04:03:06 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-pre7 - no DRQ after issuing WRITE
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sun, 25 Jan 2004 10:03:03 +0100
Message-ID: <x6ptd8l7so@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo.tosatti@cyclades.com>:

| Please help testing! :)

Here we go: http://gzp.odpn.net/tmp/linux-2.4.25-pre7/

The "no DRQ after issuing WRITE" problem with 2 120GB Seagate
harddisk. I don't think its hw problem, because these disks are fine
in other environment. More "load" related, without running them in sw
raid mode, the problem doesn't hit me so quickly.

