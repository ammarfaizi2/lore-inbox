Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbTBFUm3>; Thu, 6 Feb 2003 15:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbTBFUm3>; Thu, 6 Feb 2003 15:42:29 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:64012 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267637AbTBFUm0>; Thu, 6 Feb 2003 15:42:26 -0500
Date: Thu, 6 Feb 2003 20:52:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: syscall documentation (3)
Message-ID: <20030206205202.A17386@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <UTC200302062009.h16K9Op23604.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200302062009.h16K9Op23604.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Feb 06, 2003 at 09:09:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 09:09:24PM +0100, Andries.Brouwer@cwi.nl wrote:
> The next new page is tkill.2
> 
> Comments welcome.
> Andries
> aeb@cwi.nl
> 
> -----------------------------------
> NAME
>        tkill - send a signal to a single process

Shouldn't kill and tkill be in one manpoage that documents both?
