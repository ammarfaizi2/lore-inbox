Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWASHPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWASHPh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWASHPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:15:36 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45499 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161067AbWASHPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:15:36 -0500
Subject: Re: [patch 2.6.16-rc1] i386: print kernel version in register dumps
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Akinobu Mita <mita@miraclelinux.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <200601181837_MC3-1-B629-329F@compuserve.com>
References: <200601181837_MC3-1-B629-329F@compuserve.com>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 08:15:32 +0100
Message-Id: <1137654933.2993.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 18:35 -0500, Chuck Ebbert wrote:
> Show first field of kernel version in register dumps like x86_64 does.
> 
> Changes output from e.g.:
> 	(2.6.16-rc1)
> to:
> 	(2.6.16-rc1 #12)
> 
> Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>


looks entirely reasonable to me, ACK

