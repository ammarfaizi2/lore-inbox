Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289314AbSAVSDJ>; Tue, 22 Jan 2002 13:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289328AbSAVSDC>; Tue, 22 Jan 2002 13:03:02 -0500
Received: from web14905.mail.yahoo.com ([216.136.225.57]:30988 "HELO
	web14905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289314AbSAVSCC>; Tue, 22 Jan 2002 13:02:02 -0500
Message-ID: <20020122180201.42898.qmail@web14905.mail.yahoo.com>
Date: Tue, 22 Jan 2002 13:02:01 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: metadata and contents in loop device
To: linux-crypto@nl.linux.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, everyone, in my loop device I want to use
different keys to en/decrypt the file contents and the
metadata of directories/file names information. But
how can I differentiate these two types of data in the
loop device? The loop device just cares about the
block. But the metadata of directories/file names
information is just the file system information. Any
idea about this? Thanks in advance.

Michael

______________________________________________________________________ 
Web-hosting solutions for home and business! http://website.yahoo.ca
