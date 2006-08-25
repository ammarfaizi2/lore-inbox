Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWHYNSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWHYNSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWHYNSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:18:46 -0400
Received: from web25803.mail.ukl.yahoo.com ([217.12.10.188]:5774 "HELO
	web25803.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751270AbWHYNSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:18:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=qrV/x5fNtIPl5ml9yQUrc4my7ipkKi80+XfMNuq095nNtnfh7ottS0YQa6yMEqY5fSniJmiP1OrMSBxFIxi9rGfJ4JdTYOmgTMkViQBb057ApY+5pbOkP26tTCIp4yLIdq69WVcNMlayq8lUeXYwZOTunXXS2ecDj+eoIsHArWU=  ;
Message-ID: <20060825131843.87416.qmail@web25803.mail.ukl.yahoo.com>
Date: Fri, 25 Aug 2006 13:18:43 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : [HELP] Power management for embedded system
To: Matthew Garrett <mjg59@srcf.ucam.org>, Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060824162034.GB19753@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> Triggering suspend/resume is already generic in the form of the 
> /sys/power/state interface. There's been discussion of producing a 
> generic battery class lately. There's some trend towards tying suspend 
> requests into the input layer, but how appropriate that is may depend on 
> the hardware in question. I think most of the pieces are in place to 
> provide an interface that isn't tied to looking like APM, and there's

what about suspend/resume event handling ? Is there something already in
place ?
 
Francis



