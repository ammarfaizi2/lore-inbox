Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbTK0Qfb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264553AbTK0Qfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:35:31 -0500
Received: from main.gmane.org ([80.91.224.249]:12703 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264549AbTK0QfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:35:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Selecting CPU frequency on Asus P4M laptop
Date: Thu, 27 Nov 2003 17:35:20 +0100
Message-ID: <yw1xsmk9bwhj.fsf@kth.se>
References: <yw1x65h5ddbn.fsf@kth.se> <20031127161143.GA10634@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YE/LqItwaHTB9EOR643AeDRLuYo=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland <marco.roeland@xs4all.nl> writes:

> On Thursday November 27th 2003 Måns Rullgård wrote:
>
>> Is there any way to change which of these will be used after booting?
>
> Have you already tried (as a module, *not* builtin) the SpeedStep
> clockmod driver (CONFIG_X86_P4_CLOCKMOD=M) or, if your Southbridge is an
> ICH[234], the ICH driver (CONFIG_X86_SPEEDSTEP_ICH=M)?

I've tried them all.  Only acpi and p4-clockmod load successfully.

-- 
Måns Rullgård
mru@kth.se

