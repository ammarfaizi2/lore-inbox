Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUAZPfa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUAZPf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:35:29 -0500
Received: from nms.rz.uni-kiel.de ([134.245.1.2]:31947 "EHLO uni-kiel.de")
	by vger.kernel.org with ESMTP id S264879AbUAZPfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:35:23 -0500
From: Mike Gabriel <mgabriel@ecology.uni-kiel.de>
Reply-To: mgabriel@ecology.uni-kiel.de
Organization: OEZK, CAU Kiel
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.24 / promise supertrak100 / udma
Date: Mon, 26 Jan 2004 16:34:14 +0100
User-Agent: KMail/1.5.4
Cc: gurus@ecology.uni-kiel.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200401261634.14726.mgabriel@ecology.uni-kiel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

i am using a promise supertrak100 ide controller unter 2.4.24 on i386 on our 
backupserver. the drives have been found and the md-driver is synchronizing 
the raid. however, i cannot kick it into udma mode. when using hdparm, it 
tells me:

galileo:/# hdparm /dev/i2o/hda
/dev/i2o/hda not supported by hdparm

what can i do, to enable udma (at least udma33 or udma66) on the controller?

mike

-- 

netzwerkteam - oekologiezentrum
Mike Gabriel
FA Geobotanik
Christian-Albrecht Universit‰t zu Kiel
Abt. Prof. Dr. K. Dierﬂen
Olshausenstr. 75
24118 kiel

fon-oezk: +49 431 880 1186
fon-home: +49 431 64 74 196

mail: mgabriel@ecology.uni-kiel.de
http://www.ecology.uni-kiel.de

