Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbTLKUHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 15:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265236AbTLKUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 15:07:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:14569 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265233AbTLKUHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 15:07:02 -0500
Date: Thu, 11 Dec 2003 21:12:13 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-wli-2
Message-ID: <20031211201213.GA12438@chiara.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031211052929.GN19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211052929.GN19856@holomorphy.com>
Organization: private site in Mannheim/Germany
X-PGP-Key: Use PGP! Get my key at http://www.cavy.de/hd.key
User-Agent: Mutt/1.5.5.1i (Linux 2.6.0-test11-wli1 i586)
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:99c799a891397f4941698a2afa7903da
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Dec 10 2003, William Lee Irwin III wrote:

> Successfully tested on a Thinkpad T21 
[....]

Compiling -wli-2 fails showing this:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
 fs/built-in.o(.text+0x29e6a): In function proc_task_readdir':
 : undefined reference to __cmpdi2'
 fs/built-in.o(.text+0x29e7d): In function proc_task_readdir':
 : undefined reference to __cmpdi2'
 make: *** [.tmp_vmlinux1] Error 1

Greetings, Heinz.
-- 
# Heinz Diehl, 68259 Mannheim, Germany
