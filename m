Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbULBKBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbULBKBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 05:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULBKBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 05:01:38 -0500
Received: from main.gmane.org ([80.91.229.2]:54983 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261579AbULBKB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 05:01:28 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: dma errors with sata_sil and Seagate disk
Date: Thu, 02 Dec 2004 11:01:17 +0100
Message-ID: <yw1xpt1tuihe.fsf@ford.inprovide.com>
References: <20041201115045.3ab20e03@homer.sarvega.com> <1101944482.30990.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:DqM2sPu6BrYvoARmPGVxnAfOKtc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mer, 2004-12-01 at 17:50, John Lash wrote:
>> I don't see any indication that Seagate has released any public firmware
>> upgrades for this drive. Anybody have a suggestion?
>
> Don't mix seagate drives and SI311x hardware is the best suggestion.

Is there some problem with Seagate drives in general?  I'm using two
ST3160827AS drives on an SI3114 controller, and haven't seen any
glitches yet.  That model is not in the blacklist, and performance is
what I'd usually expect.  Is it pure luck that has kept me away from
problems?

-- 
Måns Rullgård
mru@inprovide.com

