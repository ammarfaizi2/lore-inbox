Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTKXUmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263927AbTKXUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:42:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34833
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263921AbTKXUml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:42:41 -0500
Date: Mon, 24 Nov 2003 12:42:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems
Message-ID: <20031124204238.GC2190@mis-mike-wstn.matchmail.com>
Mail-Followup-To: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <yw1x1xrxpuha.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x1xrxpuha.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 06:05:53PM +0100, M?ns Rullg?rd wrote:
> If a SUID program is found to have a security hole, the administrator
> should make sure he removes all links to it when deleting it, just to
> be safe.

or in the common case:
s/administrator/package manager/
