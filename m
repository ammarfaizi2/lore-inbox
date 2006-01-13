Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422775AbWAMSHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422775AbWAMSHt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWAMSHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:07:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13457 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422771AbWAMSHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:07:47 -0500
Date: Fri, 13 Jan 2006 18:07:47 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       "James. Bottomley @ steeleye. com Andrew Morton" <akpm@osdl.org>
Subject: Re: PATCH [1/2] scsi/BusLogic.c:Handle scsi_add_host failure
Message-ID: <20060113180746.GD20718@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ashutosh Naik <ashutosh.naik@gmail.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"James. Bottomley @ steeleye. com Andrew Morton" <akpm@osdl.org>
References: <81083a450601110135t4f038fbds1bce6d8c9302e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81083a450601110135t4f038fbds1bce6d8c9302e89@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

same problem again. seems like all in your series have it..
