Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbTIVI0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 04:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbTIVI0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 04:26:07 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:49615 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S263054AbTIVI0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 04:26:04 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Synaptics bk8 + patches
Date: Mon, 22 Sep 2003 10:25:59 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309221025.59347.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,
	I just tried your last patches at http://w1.894.telia.com/~u89404340/
patches/touchpad/2.6.0-test5-bk8/v1/.

They not only gives the sync's error:

Synaptics driver lost sync at 4th byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver lost sync at 1st byte
Synaptics driver resynced.

but also the pointer is almost uncontrollable. 

The pointer's response is not coherent, mainly the speed. Sometimes is 
slower, other faster, sometimes the mouse even doesn't move, especially 
in the y axis.

Also, most of the time a tap is considered a very short drag.


Cheers.

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

