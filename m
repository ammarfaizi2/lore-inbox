Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUHJLth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUHJLth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 07:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUHJLth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 07:49:37 -0400
Received: from main.gmane.org ([80.91.224.249]:34731 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264396AbUHJLtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 07:49:35 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Tue, 10 Aug 2004 13:49:30 +0200
Message-ID: <yw1xsmav8b79.fsf@kth.se>
References: <200408061330.i76DU2Tm005937@burner.fokus.fraunhofer.de> <20040806151017.GG23263@suse.de>
 <20040810084159.GD10361@merlin.emma.line.org>
 <20040810101123.GB2743@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:lKLqFrX77cqh94R2hF5HPjZMlEY=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw <erik@harddisk-recovery.com> writes:

> On Tue, Aug 10, 2004 at 10:41:59AM +0200, Matthias Andree wrote:
>> It's not exactly fun if everything can do 48X but your favorite OS
>> (Linux 2.4) is limited to say 8X because it only does PIO in spite of
>> hdparm settings and everything else.
>
> FWIW, we burn CDs at 40x with a 2.4 kernel. It is however a hardware or
> driver related issue: no problems whatsoever with VIA IDE interfaces,
> but only PIO with the CD writer connected to a Promise 20268.

Problems with ATAPI devices on Promise cards are common, even Promise
admits that.

-- 
Måns Rullgård
mru@kth.se

