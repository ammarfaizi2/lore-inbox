Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUE1C3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUE1C3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 22:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265786AbUE1C3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 22:29:11 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:49798 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265763AbUE1C3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 22:29:10 -0400
Date: Thu, 27 May 2004 19:29:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Message-ID: <1130000.1085711344@[10.10.2.4]>
In-Reply-To: <Pine.GSO.4.33.0405272153460.14297-100000@sweetums.bluetronic.net>
References: <Pine.GSO.4.33.0405272153460.14297-100000@sweetums.bluetronic.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When was recurrsion disabled on the ftp server? (LIST -lRat doesn't work
> anymore)
> 
> Lukily, I have mirror configured to not deleted the entire archive.  This
> has happened before.

They switched to vsftpd very recently ... presumably then. 
Why would you mirror via ftp, instead of rsync anyway?

M.

