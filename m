Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSDEADC>; Thu, 4 Apr 2002 19:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289484AbSDEACm>; Thu, 4 Apr 2002 19:02:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287817AbSDEACa>; Thu, 4 Apr 2002 19:02:30 -0500
Subject: Re: forth interpreter as kernel module
To: davidw@dedasys.com (David N. Welton)
Date: Fri, 5 Apr 2002 01:19:43 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <877knnowi8.fsf@dedasys.com> from "David N. Welton" at Apr 05, 2002 01:49:03 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16tHSB-00078F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would be interested in comments on what should be fixed in the code,
> although I may not have time to act on them.

Strange. The one area forth does have sort of relevance may be outside the
x86 world. The portable boot rom standards (the one everyone ignored for
x86) is all about forth stuff. I don't know if anyone has use for a forth
engine that can speak that ?
