Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265276AbUBALqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 06:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUBALqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 06:46:09 -0500
Received: from main.gmane.org ([80.91.224.249]:54145 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265276AbUBALqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 06:46:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Date: Sun, 01 Feb 2004 12:46:02 +0100
Message-ID: <yw1xllnnqayt.fsf@kth.se>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
 <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
 <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com>
 <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com>
 <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
 <200402011106.i11B6E7F000557@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Gmane-NNTP-Posting-Host: ti200710a080-2939.bb.online.no
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:EjAaK3lvWRdvCX/+ZzeS8Oe2aRg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> A cheap cludge would be an optional second GPU on the card just to do
> the required VGA modes, with an analogue video pass-through.  That
> would make the VGA cards more expensive than a single GPU which
> incorporated VGA, but add almost nothing in cost or complexity terms
> to the non-VGA cards.

The DEC TGA series cards did something like that, using a Cirrus Logic
chip for the VGA support.

-- 
Måns Rullgård
mru@kth.se

