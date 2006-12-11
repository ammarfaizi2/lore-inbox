Return-Path: <linux-kernel-owner+w=401wt.eu-S1760625AbWLKEsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760625AbWLKEsn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762394AbWLKEsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:48:42 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:44524 "EHLO
	liaag1ad.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760625AbWLKEsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:48:42 -0500
Date: Sun, 10 Dec 2006 23:46:44 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: PAE/NX without performance drain?
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200612102347_MC3-1-D49B-AB98@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <457B1F02.7030409@comcast.net>

On Sat, 09 Dec 2006 15:39:30 -0500, John Richard Moser wrote:

> Is it possible to give some other way to get the hardware NX bit working
> in 32-bit mode, without the apparently massive performance penalty of
> HIGHMEM64?

If your hardware can run the x86_64 kernel, try using that with your
i386 userspace.  It works here...

-- 
Chuck
"Even supernovas have their duller moments."

