Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267436AbTAVLie>; Wed, 22 Jan 2003 06:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbTAVLie>; Wed, 22 Jan 2003 06:38:34 -0500
Received: from mx02.cyberus.ca ([216.191.240.26]:27918 "EHLO mx02.cyberus.ca")
	by vger.kernel.org with ESMTP id <S267436AbTAVLie>;
	Wed, 22 Jan 2003 06:38:34 -0500
Date: Wed, 22 Jan 2003 06:47:35 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: netdev@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: ok, which wise guy did this?
Message-ID: <20030122064047.D41405@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just booted my spanking new P4 HT PC last night using 2.5.58
and to my dissapointment the enumeration of the ethx devices is
reversed. I have 5 ethernet ports on this; eth0-4 on 2.4.x are now listed
as eth4-0. This is rude.
I immediately pointed a finger at monsieur J Garzik (thinking ethernet,
PCI enumeration hmm) but he has denied any responsibility ;-> ;-> He
thinks it may be the sysfs people.
Can anyone give justification for this? Regardless of justification
can we have some form of backward compatibility flag?

cheers,
jamal
