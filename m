Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTAVQsz>; Wed, 22 Jan 2003 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261857AbTAVQsz>; Wed, 22 Jan 2003 11:48:55 -0500
Received: from havoc.daloft.com ([64.213.145.173]:11179 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261855AbTAVQsy>;
	Wed, 22 Jan 2003 11:48:54 -0500
Date: Wed, 22 Jan 2003 11:57:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: 3c509.c
Message-ID: <20030122165757.GA20929@gtf.org>
References: <UTC200301220111.h0M1BQg03940.aeb@smtp.cwi.nl> <200301221644.h0MGion18794@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301221644.h0MGion18794@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 11:44:50AM -0500, James Bottomley wrote:
> However, looking through the source, the 3c509 driver is broken anyway for MCA 
> (done by the eisa sysfs patches), so I think I can probably just add the extra 
> pieces to convert it to the new sysfs MCA API.

Excellent... that's what I was hoping would happen :)

