Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTESSLz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbTESSLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:11:55 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:8965 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262633AbTESSLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:11:53 -0400
Date: Mon, 19 May 2003 19:24:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Ford <david+cert@blue-labs.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519192445.A27338@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Ford <david+cert@blue-labs.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519124539.B8868@infradead.org> <1053348984.9142.98.camel@workshop.saharact.lan> <20030519140617.A15587@infradead.org> <3EC91CF2.7020602@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EC91CF2.7020602@blue-labs.org>; from david+cert@blue-labs.org on Mon, May 19, 2003 at 02:05:38PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 02:05:38PM -0400, David Ford wrote:
> How about not passing the buck off to "the vendor" and helping "this 
> vendor" make sanitized headers.

Wjhy?  Someone already did the work so why should I help to duplicate
the effort.  Something doesn't have to be bad just because it's from
redhat.

> Not everybody copies RH and changes the text files from "RH" to "my 
> distribution name".

It would certainly help gentoo..

