Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422769AbWAMSGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWAMSGR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbWAMSGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:06:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8081 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422768AbWAMSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:06:16 -0500
Date: Fri, 13 Jan 2006 18:06:15 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-scsi@vger.kernel.org, James.Bottomley@steeleye.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux@arm.linux.org.uk
Subject: Re: [PATCH] scsi/arm/ecoscsi.c Handle scsi_add_host failure
Message-ID: <20060113180615.GB20718@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ashutosh Naik <ashutosh.naik@gmail.com>, linux-scsi@vger.kernel.org,
	James.Bottomley@steeleye.com, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux@arm.linux.org.uk
References: <81083a450601100441s7675d584jd10db5a8e6ccaf58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81083a450601100441s7675d584jd10db5a8e6ccaf58@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same issue as with the last patch.
