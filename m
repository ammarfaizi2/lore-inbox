Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTALM1g>; Sun, 12 Jan 2003 07:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265222AbTALM1g>; Sun, 12 Jan 2003 07:27:36 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:39929 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265077AbTALM1f>; Sun, 12 Jan 2003 07:27:35 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.44.0301120223350.23406-100000@dell> 
References: <Pine.LNX.4.44.0301120223350.23406-100000@dell> 
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: this is what i had in mind for fs/Kconfig 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Jan 2003 12:36:22 +0000
Message-ID: <19956.1042374982@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Cramfs isn't a pseudo-fs. Minix is a non-Linux fs, as are JFS and XFS I
suppose. JFFS and JFFS2 are _not_ non-Linux filesystems (but neither are
they 'Typical hard disk filesystems')

The help text for NFS shouldn't say:
          A superior but less widely used alternative to NFS is provided by
          the Coda file system; see "Coda file system support" below.

... because Coda is actually _above_ :)


--
dwmw2


