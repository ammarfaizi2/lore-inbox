Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289288AbSAVSfA>; Tue, 22 Jan 2002 13:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289336AbSAVSeu>; Tue, 22 Jan 2002 13:34:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:16022 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S289288AbSAVSed>;
	Tue, 22 Jan 2002 13:34:33 -0500
Subject: Re: metadata and contents in loop device
From: Xavier Bestel <xavier.bestel@free.fr>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-crypto@nl.linux.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020122180201.42898.qmail@web14905.mail.yahoo.com>
In-Reply-To: <20020122180201.42898.qmail@web14905.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 22 Jan 2002 19:28:49 +0100
Message-Id: <1011724130.12235.1.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-22 at 19:02, Michael Zhu wrote:
> Hello, everyone, in my loop device I want to use
> different keys to en/decrypt the file contents and the
> metadata of directories/file names information. But
> how can I differentiate these two types of data in the
> loop device? The loop device just cares about the
> block. But the metadata of directories/file names
> information is just the file system information. Any
> idea about this? Thanks in advance.

Mmmh ... I don't really see the point, but perhaps you should look at
stegfs (sorry, don't remember the URL)


