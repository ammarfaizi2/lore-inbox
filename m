Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTLKQfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 11:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTLKQfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 11:35:40 -0500
Received: from holomorphy.com ([199.26.172.102]:33254 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265151AbTLKQfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 11:35:40 -0500
Date: Thu, 11 Dec 2003 08:35:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: moth@magenta.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211163534.GJ8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	moth@magenta.com, linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <20031211094148.G28449@links.magenta.com> <20031211150011.GF8039@holomorphy.com> <20031211111741.H28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211111741.H28449@links.magenta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 11:17:41AM -0500, moth@magenta.com wrote:
> I'm not wondering if > 2GB is supported.  I'm trying to get 2GB
> to work (and I'm having a problem -- perhaps because I believe
> Documentation/memory.txt doesn't cover the issues I'm facing).
> I've not yet bothered with highmem, but I will if building a 64 bit
> kernel doesn't get me access to 2GB.
> Does that answer your question?

You should be fine with a 64-bit kernel.


-- wli
