Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSHFRsr>; Tue, 6 Aug 2002 13:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSHFRsr>; Tue, 6 Aug 2002 13:48:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:25068 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314548AbSHFRsq>; Tue, 6 Aug 2002 13:48:46 -0400
Date: Tue, 06 Aug 2002 10:56:26 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Bernd Schubert <bernd-schubert@web.de>, linux-kernel@vger.kernel.org
Subject: Re: clear dentry and inode cache
Message-ID: <14860000.1028656586@w-hlinder>
In-Reply-To: <200208061612.58825.bernd-schubert@web.de>
References: <200208061612.58825.bernd-schubert@web.de>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, August 06, 2002 16:12:58 +0200 Bernd Schubert <bernd-schubert@web.de> wrote:

> Hi,
> 
> is there a a way to clear the dentry and inode cache via proc interface ?
> 

Have you looked at 'bdflush'? That might help.

Hanna

