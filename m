Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbTKERXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTKERXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:23:13 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:47288 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262989AbTKERXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:23:12 -0500
Date: Wed, 5 Nov 2003 15:23:10 -0200
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: IDE disk information changed from 2.4 to 2.6
Message-ID: <20031105172310.GE5304@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Upgrading from kernel 2.4 to 2.6 the CHS information for the same hardware 
changed. This behaviour is correct? 

Using 2.4:
hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=784/255/63, UDMA (33)

Using 2.6:
hda: 12594960 sectors (6449 MB) w/2048KiB Cache, CHS=13328/15/63, UDMA (33)

regards,

-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
