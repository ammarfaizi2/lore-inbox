Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbVLBKey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbVLBKey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 05:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbVLBKex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 05:34:53 -0500
Received: from mail.fccps.cz ([195.146.112.10]:62479 "EHLO mail.fccps.cz")
	by vger.kernel.org with ESMTP id S1751778AbVLBKex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 05:34:53 -0500
From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To: linux-kernel@vger.kernel.org
Date: Fri, 02 Dec 2005 11:34:58 +0100
MIME-Version: 1.0
Subject: Re: SuperMicro X6DHE-XG2 + 2x Irwindale in 2.4 SMP
Message-ID: <43903162.16758.8146B879@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear everyone,

it seems that there is one BIOS SETUP option that escaped my 
attention: in the BIOS version 1.3a, it's called the
"C1 enhanced mode".
In order to make Linux 2.4 work on the SuperMicro boards with 
Irwindale CPU's, this toggle has to be disabled.

Frank Rysanek

>
> Dear everyone,
> 
> I'd like to report what seems to be a minor SMP misbehavior in the 
> 2.4 kernel.
>
> My hardware:
> SuperMicro X6DHE-XG2 motherboard (i7520 + 2x PXH)
> BIOS versions 1.2c and 1.3a (a flavour of Phoenix server BIOS)
> 2x Intel XEON Irwindale (2 MB L2) @ 3.4 GHz

