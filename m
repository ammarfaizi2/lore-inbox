Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWJEVi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWJEVi0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWJEVi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:38:26 -0400
Received: from [198.99.130.12] ([198.99.130.12]:43699 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932236AbWJEViY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:38:24 -0400
Date: Thu, 5 Oct 2006 17:36:33 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml: allow using again x86/x86_64 crypto code
Message-ID: <20061005213633.GB6790@ccure.user-mode-linux.org>
References: <11600768683307-git-send-email-blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11600768683307-git-send-email-blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 09:34:28PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Enable compilation of x86_64 crypto code;, and add the needed constant to make
> the code compile again (that macro was added to i386 asm-offsets between 2.6.17
> and 2.6.18, in 6c2bb98bc33ae33c7a33a133a4cd5a06395fece5).
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Acked-by: Jeff Dike <jdike@addtoit.com>
