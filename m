Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWF3TCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWF3TCO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933095AbWF3TCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:02:13 -0400
Received: from isilmar.linta.de ([213.239.214.66]:23194 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S933056AbWF3TCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:02:11 -0400
Date: Fri, 30 Jun 2006 20:53:13 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill open-coded offsetof in cm4000_cs.c ZERO_DEV()
Message-ID: <20060630185313.GB8721@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20060615112655.GM27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615112655.GM27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 12:26:55PM +0100, Al Viro wrote:
> ... to make sure that it doesn't break again when a field changes (see
> "[PATCH] pcmcia: fix zeroing of cm4000_cs.c data" for recent example).

Applied.

Thanks,
	Dominik
