Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWE3QVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWE3QVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 12:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWE3QVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 12:21:37 -0400
Received: from isilmar.linta.de ([213.239.214.66]:18645 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932307AbWE3QVQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 12:21:16 -0400
Date: Mon, 29 May 2006 17:12:39 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Florin Malita <fmalita@gmail.com>
Cc: linux-pcmcia@lists.infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCMCIA: missing pcmcia_get_socket() result check
Message-ID: <20060529151239.GA11113@dominikbrodowski.de>
Mail-Followup-To: Florin Malita <fmalita@gmail.com>,
	linux-pcmcia@lists.infradead.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <4475069B.9060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4475069B.9060100@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 24, 2006 at 09:21:31PM -0400, Florin Malita wrote:
> The result of pcmcia_get_socket() may be NULL but ds_event() uses it
> without checking.

Applied, thanks.

	Dominik
