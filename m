Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTESLaM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTESLaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:30:12 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:53265 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262409AbTESLaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:30:11 -0400
Date: Mon, 19 May 2003 12:43:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519124306.A8868@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	KML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519105152.GD8978@holomorphy.com> <1053342842.9152.90.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053342842.9152.90.camel@workshop.saharact.lan>; from azarah@gentoo.org on Mon, May 19, 2003 at 01:14:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 01:14:02PM +0200, Martin Schlemmer wrote:
> like imon support in fam for example ?  The imon.h will not
> be in the 'sanitized copy' ....

Imon is a braindead IRIX feature and SGI stopped doing Linux patches
for it when dnotify became more common.  So WTF are you talking about?

