Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266483AbUBLSMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUBLSMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:12:33 -0500
Received: from [212.28.208.94] ([212.28.208.94]:45572 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266483AbUBLSMc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:12:32 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 19:12:24 +0100
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <1076604650.31270.20.camel@ulysse.olympe.o2t>
In-Reply-To: <1076604650.31270.20.camel@ulysse.olympe.o2t>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402121912.24146.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 17.50, you wrote:
> But that's not a reason not to fix the core problem - I don't want to
> spent hours fixing filenames next time someone comes up with a new
> encoding. Please put valid encoding info somewhere or declare filenames
> are utf-8 od utf-16 only - changing user locale should not corrupt old
> data.

Yes! 

-- robin
