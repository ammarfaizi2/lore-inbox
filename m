Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTESFZT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 01:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbTESFZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 01:25:19 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:272 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261294AbTESFZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 01:25:19 -0400
Date: Mon, 19 May 2003 06:38:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519063813.A30004@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	KML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053292339.10127.45.camel@nosferatu.lan>; from azarah@gentoo.org on Sun, May 18, 2003 at 11:12:19PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 11:12:19PM +0200, Martin Schlemmer wrote:
> Yes, the standard answer.  So what kernel headers should glibc
> be compiled against then ?

None.  But as glibc still hasn't been fixed use kernel headers from linux 2.4.

