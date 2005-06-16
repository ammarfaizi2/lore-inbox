Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFPH43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFPH43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVFPH43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:56:29 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:21147 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261189AbVFPH42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:56:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=S41ZUCGdXuf4yi5ahQcBejnJV2cSVv7F3PLbK81I/n+jhuOtw9bJJPWv92FbEv5XxfOxIKUrVgXUwl7+1UO4hC/djS+3CWTfRjBlH5tVsafmThgU6E8ZmLQwRD9xdTvxsMvbmDNSHo3v/ewBxdVNO187UDry3ZSX0jDyHRm1Yu8=  ;
Message-ID: <20050616075627.26543.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 16 Jun 2005 09:56:27 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: KD_GRAPHICS mode for console
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering why KD_GRAPHICS mode is for ? Is it only used to blank screen
and turn off echo or can a console driver use it to draw pixels in "con_putcs"
function ?

BTW "KD_" in "KD_GRAPHICS" stand for what ?

thanks

           Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
