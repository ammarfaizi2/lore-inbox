Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUGAQMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUGAQMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265992AbUGAQMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:12:46 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:43663
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S265973AbUGAQMi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:12:38 -0400
Date: Thu, 1 Jul 2004 12:16:20 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
Message-ID: <20040701161620.GA2939@animx.eu.org>
References: <m2hdsr6du0.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2hdsr6du0.fsf@telia.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch adds support for using DVD+RW drives as writable block
> devices under the 2.6.7-bk13 kernel.
> 
> The patch is based on work from:
> 
>         Andy Polyakov <appro@fy.chalmers.se> - Wrote the 2.4 patch
>         Nigel Kukard <nkukard@lbsd.net> - Initial porting to 2.6.x
> 
> It works for me using an Iomega Super DVD 8x USB drive.

Any chance of this working with dvd±r?  (Same question for cd-r on the other
patch).

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
