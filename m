Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276643AbRJPTZu>; Tue, 16 Oct 2001 15:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276646AbRJPTZk>; Tue, 16 Oct 2001 15:25:40 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:26026 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S276643AbRJPTZ0>; Tue, 16 Oct 2001 15:25:26 -0400
Date: Tue, 16 Oct 2001 20:05:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: some bugs in preparsing directives
Message-ID: <20011016200553.B22449@flint.arm.linux.org.uk>
In-Reply-To: <20011016120201.S6667@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011016120201.S6667@dspnet.fr.eu.org>; from reiga@dspnet.fr.eu.org on Tue, Oct 16, 2001 at 12:02:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2001 at 12:02:01PM +0200, Jean-Luc Leger wrote:
> * drivers/acorn/scsi/ecoscsi.c : #endif missing at the end of file
> -> the #if directive is in line 235

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

