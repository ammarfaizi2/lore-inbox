Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUBKX2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 18:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUBKX2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 18:28:33 -0500
Received: from codepoet.org ([166.70.99.138]:38581 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S266064AbUBKX2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 18:28:32 -0500
Date: Wed, 11 Feb 2004 16:28:29 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.2.0
Message-ID: <20040211232829.GA15450@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
References: <200402112339.55593.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402112339.55593.mmazur@kernel.pl>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Feb 11, 2004 at 11:39:55PM +0100, Mariusz Mazur wrote:
> Available at: http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> 
> Changes:
> - applied changes from 2.6.2 kernel
> - added an empty linux/compiler.h (I really hate myself for doing this, but 
> don't have much choice... many apps include it as a workaround for broken 
> headers that come with linux)
> - some minor changes... mostly removing duplicate definitons and replacing 
> them with calls to glibc's headers

Thoughts on adding sanitized include/scsi/ ?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
