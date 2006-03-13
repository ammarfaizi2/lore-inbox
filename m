Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWCMK1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWCMK1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 05:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWCMK1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 05:27:23 -0500
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:6524 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750753AbWCMK1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 05:27:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EeylCvzannttx73vGVR2tqMPEDSknm3t0wNhlYY7PgunumbRjP+WWOoXgi6aV2/MK0iAxWI2sJd4w3tK8DBpSD4xpbBfp907pWJF9h0NbTafXWJ7dycr7jJwYVuDaFxaNkoVfGj2MwYjzhnrcjCkg94oIA5E2uSK1mB7VygeL9I=  ;
Message-ID: <20060313102721.76215.qmail@web26913.mail.ukl.yahoo.com>
Date: Mon, 13 Mar 2006 11:27:21 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: sis96x compiled in by error: delay of one minute at boot
To: linux-kernel@vger.kernel.org
Cc: sensors@stimpy.netroedge.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

 I just forgot to remove CONFIG_I2C_SIS96X=y in my kernel (minimum support
possible for my PC hardware based on VIA, no module at all) and get a one
minute delay at boot when trying to probe this non existing device in
2.6.16-rc5.
 Maybe the abscence test should be quicker.

  Cheers,
  Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
