Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269846AbUIDJTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269846AbUIDJTg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269847AbUIDJTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:19:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:39608 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269846AbUIDJTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:19:34 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: sboyce@blueyonder.co.uk
Subject: Re: NVIDIA Driver 1.0-6111 fix
Date: Sat, 4 Sep 2004 11:25:15 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <41390988.2010503@blueyonder.co.uk>
In-Reply-To: <41390988.2010503@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409041125.21915.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 September 2004 02:17, Sid Boyce wrote:
> The NVIDIA Linux Discussion forum has a patch that works with 2.6.9-rc1-mm3
> http://gentoo.kems.net/gentoo-x86-portage/media-video/nvidia-kernel/files/1
>.0.6111/nv_enable_pci.patch Regards
> Sid.

this patch only fixes the "routeirq" problem, or? because i can't see any 
changes for pci_find_class.

regards,
dominik
