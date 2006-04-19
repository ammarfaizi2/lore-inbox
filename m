Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWDSO0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDSO0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 10:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDSO0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 10:26:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18882 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750797AbWDSO0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 10:26:45 -0400
Subject: Re: problems compiling kernel module
From: Arjan van de Ven <arjan@infradead.org>
To: Fernando Barsoba <fbarsoba@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44463EA8.9090301@hotmail.com>
References: <44463EA8.9090301@hotmail.com>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 16:26:43 +0200
Message-Id: <1145456803.3085.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 09:44 -0400, Fernando Barsoba wrote:
> 
> 
> I am really stuck with this thing.. For couple of days i have been 
> trying to compile a kernel module. I have been following the info in 
> http://www.faqs.org/docs/kernel/x204.html. But no success... i 
> recompiled the latest kernel version, and i think i trying to compile 

your makefile is bust; please read Documentation/kbuild for a 2.6 level
makefile (yours is a bad job even for 2.4 kernels but it'll more or less
work there)


