Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUAVLHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 06:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266226AbUAVLHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 06:07:33 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:14600 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266224AbUAVLHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 06:07:32 -0500
Date: Thu, 22 Jan 2004 11:07:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm1
Message-ID: <20040122110731.A9319@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20040122013501.2251e65e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040122013501.2251e65e.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 22, 2004 at 01:35:01AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> uml-update.patch
>   UML update

And this one brings in perfectly broken 2.4 block drivers.  This quality
of the UML code makes me nervous.

