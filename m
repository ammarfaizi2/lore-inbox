Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUE0U4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUE0U4M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUE0U4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 16:56:12 -0400
Received: from [213.146.154.40] ([213.146.154.40]:19118 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265237AbUE0U4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 16:56:06 -0400
Date: Thu, 27 May 2004 21:56:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't make XFS work with 2.6.6
Message-ID: <20040527205604.GB20499@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <200405271736.08288.dj@david-web.co.uk> <200405271854.20787.dj@david-web.co.uk> <1085680806.5311.44.camel@buffy> <200405271925.24650.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405271925.24650.dj@david-web.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cna you send dmesg output for 2.4 and 2.6 if you can caputer the latter.
If not please compare them manually and check whether hda is still the
same device as in 2.4.  Also check if 2.6 finds more or less partitions.

