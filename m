Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267840AbTBRPPi>; Tue, 18 Feb 2003 10:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267841AbTBRPPi>; Tue, 18 Feb 2003 10:15:38 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:11277 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267840AbTBRPPh>; Tue, 18 Feb 2003 10:15:37 -0500
Date: Tue, 18 Feb 2003 15:25:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.5.62]: 2/3: Make SCSI low-level drivers also a seperate, complete selectable submenu
Message-ID: <20030218152520.A16760@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <200302181354.02278.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302181354.02278.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Tue, Feb 18, 2003 at 02:02:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 02:02:10PM +0100, Marc-Christian Petersen wrote:
> so you can disable all SCSI lowlevel drivers at once.

Why? just disable CONFIG_SCSI instead of adding an artifical option
