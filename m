Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUEFKyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUEFKyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 06:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUEFKyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 06:54:06 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:56593 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262003AbUEFKyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 06:54:02 -0400
Date: Thu, 6 May 2004 11:53:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Panin <pazke@donpac.ru>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] Port PIIX4 I2C driver to new DMI probing
Message-ID: <20040506115358.A14696@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrey Panin <pazke@donpac.ru>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <10838395553579@donpac.ru> <1083839558750@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1083839558750@donpac.ru>; from pazke@donpac.ru on Thu, May 06, 2004 at 02:32:38PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK the piix is used on a bunch of non-x86 platforms.  
