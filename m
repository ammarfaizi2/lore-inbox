Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264911AbUFHJdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264911AbUFHJdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 05:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUFHJdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 05:33:21 -0400
Received: from gate.corvil.net ([213.94.219.177]:11015 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S264911AbUFHJdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 05:33:20 -0400
Message-ID: <40C58781.1060200@draigBrady.com>
Date: Tue, 08 Jun 2004 10:31:45 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <de@axiros.com>
CC: David Woodhouse <dwmw2@infradead.org>, cijoml@volny.cz,
       linux-kernel@vger.kernel.org
Subject: Re: jff2 filesystem in vanilla
References: <200406041000.41147.cijoml@volny.cz> <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com> <1086390590.4588.70.camel@imladris.demon.co.uk> <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com>
In-Reply-To: <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:
> Believe it or not but JFFS2 is the only filesystem that works
> reasonably on CF, especially when the system is used mostly read
> only and the device is cut off from power every now and then. ;)
> 
> I tried different FS which we used read-only (and remounted it
> r/w in case we needed it) in the last tries but we still were
> able to kill a card without a problem and had FS corruption which
> needed a console to fix.

Can you give more detail on how you were able to "kill a card".
Were there hot spots in those filesystems?

Pádraig.
