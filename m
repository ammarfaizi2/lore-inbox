Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVALXZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVALXZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVALXXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:23:37 -0500
Received: from terrhq.ru ([81.222.97.18]:33754 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S261570AbVALXTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:19:52 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] Merging?
Date: Thu, 13 Jan 2005 02:19:31 +0300
User-Agent: KMail/1.7.1
References: <200501122233.58450.vincenzo_mlRE.MOVE@yahoo.it>
In-Reply-To: <200501122233.58450.vincenzo_mlRE.MOVE@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130219.32461.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 13 January 2005 00:33, you wrote:
> a particular filesystem and has ended up resorting to plasticfs (which
> uses the LD_PRELOAD trick - not quite satisfying but it does not
>
> require kernel patching) saying:
> > Most of the problem I have [...] will still be in a better
> > MLFUSE, which is that it requires to modify the kernel by loading a
> > module (which is often tied to one particular version of Linux which
> > means that it is tedious to maintain such module), and users hate
> > that.
Can't agree more. I don't want to release my fuse-based SMB-connector (smb 
kioslave/gnome-vfs replacement :-) for exactly this reason - having released 
some projects earlier , I can't afford (in terms of time) to answer emails 
asking how to install fuse , where to grab it and which version, how to build 
etc, so I'm eagerly awaiting when fuse will be merged and I could point to 
kernel.org and required kernel version... 
Right now I think -mm tree will be a good starting point to instantly increase 
fuse testing base to iron out possible glitches and to ensure official 
acceptance.
-- 
Managing your Territory since the dawn of times ...
