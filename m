Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbUC2HQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 02:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUC2HQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 02:16:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28060 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262720AbUC2HQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 02:16:43 -0500
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nbd-server?
References: <20040329053939.GO21875@rdlg.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Mar 2004 00:15:56 -0700
In-Reply-To: <20040329053939.GO21875@rdlg.net>
Message-ID: <m1hdw8gm37.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert L. Harris" <Robert.L.Harris@rdlg.net> writes:

>   I'm looking at messing with network block devices and found 2 "servers"
> in the debian unstable tree.  "nbd-server" and "enbd" (enhanced network
> block device support).  Is either one better than the other?

nbd is simple and works.  I have managed to at least oops both enbd
and drbd.  They have more features but...

Eric
