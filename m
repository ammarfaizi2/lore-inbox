Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVCIKKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVCIKKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 05:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVCIKKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 05:10:15 -0500
Received: from web51402.mail.yahoo.com ([206.190.38.181]:60593 "HELO
	web51402.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262234AbVCIKKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 05:10:11 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=yuq7/7sGopAv8jEFsccgqXUatBTip+cu+aL3HWhfvarZunPAnUEe1vJDJvHLNK0NL0ce777ytB1N5kxI7125M8atknBg2aAWGe7qAjG5DfmX/mJvKXlL2vtEZFOB1oCwF5Ifxi0RtsL69ZRl2yCJ+F6aJa4xPIEbbrOSq99ili4=  ;
Message-ID: <20050309101010.93190.qmail@web51402.mail.yahoo.com>
Date: Wed, 9 Mar 2005 11:10:10 +0100 (CET)
From: Joerg Pommnitz <pommnitz@yahoo.com>
Subject: Re: select(2), usbserial, tty's and disconnect
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> I thought this (hangup on remove [jpo]) had been merged, but I could be
> wrong.

I just checked bitkeeper. The patch went in some time ago:

4 months eolson 1.126 usb-serial: add tty_hangup on disconnect

Regards
  Joerg


	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
