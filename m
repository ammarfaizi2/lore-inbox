Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbUCZNQW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 08:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264041AbUCZNQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 08:16:22 -0500
Received: from quechua.inka.de ([193.197.184.2]:40643 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S264038AbUCZNQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 08:16:20 -0500
Date: Fri, 26 Mar 2004 14:16:29 +0100
From: Eduard Bloch <edi@gmx.de>
To: David Schwartz <davids@webmaster.com>
Cc: debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
Message-ID: <20040326131629.GB26910@zombie.inka.de>
Mail-Followup-To: David Schwartz <davids@webmaster.com>,
	debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040325225423.GT9248@cheney.cx> <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* David Schwartz [Thu, Mar 25 2004, 04:41:23PM]:

> > IMHO code that can be compiled would probably be the preferred form
> > of the work.
> 
> 	You are seriously arguing that the obfuscated binary of the firmware is the
> preferred form of the firmware for the purpose of making modifications to
> it?!

Yes, the driver authors PREFERS to make the changes on the C source
code, he never has to modify the firmware. Exactly what the GPL
requests, where is your problem?

Regards,
Eduard.
-- 
Der Krieg ist ein Massaker von Leuten, die sich nicht kennen, zum
Nutzen von Leuten, die sich kennen, aber nicht massakrieren.
		-- Paul Ambroise Valéry
