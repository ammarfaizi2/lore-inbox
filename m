Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUGAX0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUGAX0Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGAX0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:26:15 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:14992
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266259AbUGAX0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:26:13 -0400
Date: Thu, 1 Jul 2004 19:29:55 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DVD+RW support for 2.6.7-bk13
Message-ID: <20040701232955.GA3682@animx.eu.org>
References: <m2hdsr6du0.fsf@telia.com> <20040701161620.GA2939@animx.eu.org> <m2u0wr4f0v.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2u0wr4f0v.fsf@telia.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any chance of this working with dvd?r?  (Same question for cd-r on the other
> > patch).
> 
> No, not for now. I think support for non-rewritable media requires
> changes both in the udf filesystem and in the pktcdvd driver.

I can understand that.  If I wish to write to dvd±rw, do i need both
patches?

The one use for dvd±r would be for backup archival when the disc isn't going
to be filled.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
