Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbTDRJAe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 05:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTDRJAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 05:00:33 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:7945 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262960AbTDRJAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 05:00:33 -0400
Date: Fri, 18 Apr 2003 10:12:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] struct loop_info
Message-ID: <20030418101227.A30284@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, akpm@digeo.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <UTC200304180906.h3I96OX01783.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200304180906.h3I96OX01783.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Fri, Apr 18, 2003 at 11:06:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2003 at 11:06:24AM +0200, Andries.Brouwer@cwi.nl wrote:
> Ask, and I'll add legacy_dev_t. I slightly prefer the present version.

Can we name it old_dev_t or dev16_t ?  We already have old_uid_t/old_gid_t
and uid16_t/hid16_t.  A bit consistency can't hurt...

