Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268479AbUHLJMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268479AbUHLJMG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 05:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268477AbUHLJMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 05:12:06 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:16399 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268474AbUHLJME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 05:12:04 -0400
Date: Thu, 12 Aug 2004 10:12:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Subject: Re: Altix I/O code reorganization - 3 of 21
Message-ID: <20040812101202.B5988@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200408112324.i7BNOZul163539@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200408112324.i7BNOZul163539@fsgi900.americas.sgi.com>; from pfg@sgi.com on Wed, Aug 11, 2004 at 06:24:35PM -0500
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You still make SN@ unusable with your first patches, this is not the
usual transformation in small steps that keeps the code useable?

Should I come over and give a one day training on path submission at SGI :)

