Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264800AbUD1OES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264800AbUD1OES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbUD1OES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:04:18 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:20997 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S264800AbUD1OCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:02:45 -0400
Date: Wed, 28 Apr 2004 11:00:22 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.6-rc3 - 2004-04-27.22.30) - 1 New warnings (gcc
 3.2.2)
Message-Id: <20040428110022.602b96df.lcapitulino@prefeitura.sp.gov.br>
In-Reply-To: <200404281321.i3SDLg3h012404@cherrypit.pdx.osdl.net>
References: <200404281321.i3SDLg3h012404@cherrypit.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 28 Apr 2004 06:21:42 -0700
John Cherry <cherry@osdl.org> escreveu:

| fs/dquot.c:1328: warning: label `out' defined but not used

 I fixed this one, and Andrew already send the fix to Linus.

PS: Is from yours reports that I'm searching for warnings to
fix. Thanks! :)


-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>
