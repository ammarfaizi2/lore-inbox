Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbVHAGpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbVHAGpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 02:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVHAGpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 02:45:05 -0400
Received: from cantor2.suse.de ([195.135.220.15]:44698 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262352AbVHAGpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 02:45:03 -0400
Date: Mon, 1 Aug 2005 08:45:02 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Remove another fixed address constraint
Message-ID: <20050801064502.GB22175@suse.de>
References: <20050725061635.GD19817@localhost.localdomain> <20050801062929.GA22102@suse.de> <20050801063554.GC13052@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050801063554.GC13052@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Aug 01, David Gibson wrote:

> Hrm.. definitely works here.  Is this with any other patches?  Can you
> send the .s file?  That might help be debug it.

It works with SLES9 gcc3, only gcc4 (or recent binutils) do not like it.
