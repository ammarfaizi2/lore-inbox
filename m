Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291087AbSAaOTU>; Thu, 31 Jan 2002 09:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291086AbSAaOTI>; Thu, 31 Jan 2002 09:19:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35341 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291085AbSAaOS4>; Thu, 31 Jan 2002 09:18:56 -0500
Subject: Re: [PATCH] Misc ICH ID changes
To: bruce@ask.ne.jp (Bruce Harada)
Date: Thu, 31 Jan 2002 14:31:55 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020131224122.59d1de9e.bruce@ask.ne.jp> from "Bruce Harada" at Jan 31, 2002 10:41:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WIFn-0002Iy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> assigned to the 820 chipset, instead of the more general ICH2. The IDE changes
> are in there because the ICHs' IDE is not quite the same as a PII4X.

Im confused. All you seem to be doing is renaming existing defines. I don't
see any other change
